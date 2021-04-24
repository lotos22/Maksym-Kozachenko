import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/restaurant_details.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';

@Injectable(as: IRestaurantRepository)
class FirebaseRestaurauntDoc implements IRestaurantRepository {
  final COLLECTION_RESTUARANTS = 'restaurants';
  final COLLECTION_REVIEWS = 'reviews';

  final FIELD_RATING = 'rating';
  final FIELD_AVG_RATING = 'avgRating';
  final FIELD_DATE_VISITED = 'dateVisited';
  final FIELD_OWNER_ID = 'ownerId';
  final FIELD_REPLIED = 'replied';
  final FIELD_REPLY = 'reply';

  final CALL_ADD_RESTAURANT = 'addRestaurant';
  final CALL_GET_PENDING_REPLIES = 'getPendingReplys';

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  final _callableOptions = HttpsCallableOptions();
  FirebaseRestaurauntDoc(
      FirebaseFirestore firestore, FirebaseFunctions functions)
      : _functions = functions,
        _firestore = firestore;

  @override
  Future<OneOf<Failure, List<Restaurant>>> getRestaurants(
      GetRestaurantsParams params) async {
    try {
      var query = _firestore
          .collection(COLLECTION_RESTUARANTS)
          .orderBy(FIELD_AVG_RATING, descending: true);

      if (params.ownerId != null) {
        query = query.where(FIELD_OWNER_ID, isEqualTo: params.ownerId);
      }

      query = query.where(
        FIELD_AVG_RATING,
        isGreaterThanOrEqualTo: params.filterByRating,
      );

      if (params.lastDocId != null) {
        final snapshot = await _firestore
            .collection(COLLECTION_RESTUARANTS)
            .doc(params.lastDocId)
            .get();
        query = query.startAfterDocument(snapshot);
      }

      query = query.limit(params.pageSize);

      final docs = await query.get();
      final list =
          docs.docs.map((e) => Restaurant.fromMap(e.id, e.data())).toList();
      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Restaurant>> addRestaurant(
      AddRestaurantParams params) async {
    try {
      final docRef = _firestore.collection(COLLECTION_RESTUARANTS).doc();

      await docRef.set({
        'name': params.name,
        'avgRating': 0,
        'numRatings': 0,
        'ownerId': params.ownerId,
      });

      final newRestaurant = await docRef.get();
      return OneOf.success(
        Restaurant.fromMap(docRef.id, newRestaurant.data()!),
      );
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> deleteRestaurant(
      DeleteRestaurantParams params) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.id)
          .delete();

      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> updateRestaurant(
    UpdateRestaurantParams params,
  ) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restaurant.id)
          .update(params.restaurant.toMap());

      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, RestaurantDetails>> getRestaurantDetails(
    GetRestaurantDetailsParams params,
  ) async {
    try {
      final best = await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restId)
          .collection(COLLECTION_REVIEWS)
          .orderBy(FIELD_RATING, descending: true)
          .limit(1)
          .get();

      final worst = await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restId)
          .collection(COLLECTION_REVIEWS)
          .orderBy(FIELD_RATING)
          .limit(1)
          .get();

      if (worst.docs.isEmpty) {
        return OneOf.success(RestaurantDetails());
      }

      final bestDoc = best.docs.first;
      final worstDoc = worst.docs.first;

      return OneOf.success(RestaurantDetails(
        bestReview: Review.fromMap(bestDoc.id, bestDoc.data()),
        worstReview: Review.fromMap(worstDoc.id, worstDoc.data()),
      ));
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
