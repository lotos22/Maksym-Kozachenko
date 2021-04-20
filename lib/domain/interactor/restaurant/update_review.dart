import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';
import 'package:toptal_test/domain/params.dart';

@injectable
class UpdateReview extends UseCase<Null, UpdateReviewParams> {
  final IRestaurantRepository _repository;
  UpdateReview(IRestaurantRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(UpdateReviewParams params) =>
      _repository.updateReview(params);
}
