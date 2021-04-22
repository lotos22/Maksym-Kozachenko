import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';


abstract class IReviewRepository {
  Future<OneOf<Failure, Null>> addRestaurantReview(
    AddRestaurantReviewParams params,
  );
  Future<OneOf<Failure, List<PendingReply>>> getPendingReplies();
  Future<OneOf<Failure, Null>> addReply(AddReplyParams params);
  Future<OneOf<Failure, Null>> updateReview(UpdateReviewParams params);
  Future<OneOf<Failure, Null>> deleteReview(DeleteReviewParams params);
  Future<OneOf<Failure, List<Review>>> getReviews(
    GetRestaurantReviewsParams params,
  );
}