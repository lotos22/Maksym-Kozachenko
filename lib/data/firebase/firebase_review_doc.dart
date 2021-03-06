import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/repository/i_review_repository.dart';

@Injectable(as: IReviewRepository)
class FirebaseReviewDoc implements IReviewRepository {
  final COLLECTION_RESTUARANTS = 'restaurants';
  final COLLECTION_REVIEWS = 'reviews';

  final FirebaseFunctions _functions;
  final FirebaseFirestore _firestore;

  final _callableOptions = HttpsCallableOptions();

  final FIELD_AVG_RATING = 'avgRating';
  final FIELD_DATE_VISITED = 'dateVisited';
  final FIELD_OWNER_ID = 'ownerId';
  final FIELD_REPLIED = 'replied';
  final FIELD_REPLY = 'reply';

  final CALL_ADD_RESTAURANT = 'addRestaurant';
  final CALL_GET_PENDING_REPLIES = 'getPendingReplys';

  FirebaseReviewDoc(FirebaseFirestore firestore, FirebaseFunctions functions)
      : _functions = functions,
        _firestore = firestore;

  @override
  Future<OneOf<Failure, List<PendingReply>>> getPendingReplies(
    GetPendingRepliesParams params,
  ) async {
    try {
      final response = await _functions
          .httpsCallable(CALL_GET_PENDING_REPLIES, options: _callableOptions)
          .call({
        'page': params.page,
        'pageSize': params.pageSize,
      });

      final list =
          (response.data as List).map((e) => PendingReply.fromJson(e)).toList();

      return OneOf.success(list);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> addReply(AddReplyParams params) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restId)
          .collection(COLLECTION_REVIEWS)
          .doc(params.docId)
          .update({
        FIELD_REPLIED: true,
        FIELD_REPLY: params.reply,
      });

      return OneOf.success(null);
    } on FirebaseException {
      return OneOf.error(Failure.notFoundFailure());
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, List<Review>>> getReviews(
    GetRestaurantReviewsParams params,
  ) async {
    try {
      var query = _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.id)
          .collection(COLLECTION_REVIEWS)
          .orderBy(FIELD_DATE_VISITED, descending: true);

      if (params.lastDocId != null) {
        final snapshot = await _firestore
            .collection(COLLECTION_RESTUARANTS)
            .doc(params.id)
            .collection(COLLECTION_REVIEWS)
            .doc(params.lastDocId)
            .get();
        query = query.startAfterDocument(snapshot);
      }

      final docs = await query.limit(params.pageSize).get();
      final reviews =
          docs.docs.map((e) => Review.fromMap(e.id, e.data())).toList();
      return OneOf.success(reviews);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Review>> addRestaurantReview(
    AddRestaurantReviewParams params,
  ) async {
    try {
      final doc = await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restaurantId)
          .get();

      if (doc.exists) {
        final docRef = _firestore
            .collection(COLLECTION_RESTUARANTS)
            .doc(params.restaurantId)
            .collection(COLLECTION_REVIEWS)
            .doc();
        await docRef.set(params.toReview(FirebaseAuth.instance.currentUser!.uid));
        final newReview = await docRef.get();

        return OneOf.success(Review.fromMap(docRef.id, newReview.data()!));
      } else {
        return OneOf.error(Failure.unknownFailure('Restaurant doesn\'t exist'));
      }
    } on FirebaseException {
      return OneOf.error(Failure.notFoundFailure());
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> deleteReview(DeleteReviewParams params) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restaurantId)
          .collection(COLLECTION_REVIEWS)
          .doc(params.reviewId)
          .delete();

      return OneOf.success(null);
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }

  @override
  Future<OneOf<Failure, Null>> updateReview(UpdateReviewParams params) async {
    try {
      await _firestore
          .collection(COLLECTION_RESTUARANTS)
          .doc(params.restaurantId)
          .collection(COLLECTION_REVIEWS)
          .doc(params.review.id)
          .update(params.review.toMap());

      return OneOf.success(null);
    } on FirebaseException {
      return OneOf.error(Failure.notFoundFailure());
    } catch (E) {
      return OneOf.error(Failure.unknownFailure(E.toString()));
    }
  }
}
