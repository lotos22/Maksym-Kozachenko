import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class GetRestaurants extends UseCase<List<Restaurant>, GetRestaurantsParams> {
  final IRestaurantRepository _repository;
  GetRestaurants(IRestaurantRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, List<Restaurant>>> run(GetRestaurantsParams params) =>
      _repository.getRestaurants(params);
}
