import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/i_review_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class GetRestaurantReviews
    extends UseCase<List<Review>, GetRestaurantReviewsParams> {
  final IReviewRepository _repository;
  GetRestaurantReviews(IReviewRepository repository)
      : _repository = repository;

  @override
  Future<OneOf<Failure, List<Review>>> run(GetRestaurantReviewsParams params) =>
      _repository.getReviews(params);
}
