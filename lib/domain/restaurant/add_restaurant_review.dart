import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';

import '../use_case.dart';

@injectable
class AddRestaurantReview extends UseCase<Null, AddRestaurantReviewParams> {
  final IRestaurantRepository _repository;
  AddRestaurantReview(IRestaurantRepository repository)
      : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(AddRestaurantReviewParams params) =>
      _repository.addRestaurantReview(params);
}
