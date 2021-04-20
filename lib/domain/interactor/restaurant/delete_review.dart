import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';
import 'package:toptal_test/domain/params.dart';

@injectable
class DeleteReview extends UseCase<Null, DeleteReviewParams> {
  final IRestaurantRepository _repository;
  DeleteReview(IRestaurantRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(DeleteReviewParams params) =>
      _repository.deleteReview(params);
}
