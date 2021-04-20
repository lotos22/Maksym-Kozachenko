import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';
import 'package:toptal_test/domain/params.dart';

@injectable
class UpdateRestaurant extends UseCase<Null, UpdateRestaurantParams> {
  final IRestaurantRepository _repository;
  UpdateRestaurant(IRestaurantRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(UpdateRestaurantParams params) =>
      _repository.updateRestaurant(params);
}
