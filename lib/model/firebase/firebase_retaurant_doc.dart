import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';

@Injectable(as: IRestaurantRepository)
class FirebaseRestaurauntDoc extends IRestaurantRepository {
  final COLLECTION_RESTUARANTS = 'restaurants';
  final COLLECTION_REVIEWS = 'reviews';

  final FIELD_AVG_RATING = 'avgRating';
  final FIELD_DATE_VISITED = 'dateVisited';
  final FIELD_OWNER_ID = 'ownerId';

  final CALL_ADD_RESTAURANT = 'addRestaurant';

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;
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

      final docs = await query.get();
      final list =
          docs.docs.map((e) => Restaurant.fromMap(e.id, e.data())).toList();
      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, List<Review>>> getReviews(
      GetRestaurantReviewsParams params) async {
    try {
      final docs = await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.id)
          .collection(COLLECTION_REVIEWS)
          .orderBy(FIELD_DATE_VISITED, descending: true)
          .get();
      final reviews = docs.docs.map((e) => Review.fromMap(e.data())).toList();
      return OneOf.success(reviews);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> addRestaurantReview(
      AddRestaurantReviewParams params) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restaurantId)
          .collection(COLLECTION_REVIEWS)
          .doc()
          .set(params.toReview());

      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> addRestaurant(AddRestaurantParams params) async {
    try {
      await _functions
          .httpsCallable(CALL_ADD_RESTAURANT, options: HttpsCallableOptions())
          .call({'name': params.name});

      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
