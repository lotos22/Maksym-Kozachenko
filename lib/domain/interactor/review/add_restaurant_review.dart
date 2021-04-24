import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_review_repository.dart';
import 'package:toptal_test/domain/use_case.dart';


@injectable
class AddRestaurantReview extends UseCase<Review, AddRestaurantReviewParams> {
  final IReviewRepository _repository;
  AddRestaurantReview(IReviewRepository repository)
      : _repository = repository;

  @override
  Future<OneOf<Failure, Review>> run(AddRestaurantReviewParams params) =>
      _repository.addRestaurantReview(params);
}
