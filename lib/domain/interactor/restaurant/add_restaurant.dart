import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

import 'package:toptal_test/domain/repository/params.dart';

@injectable
class AddRestaurant extends UseCase<Restaurant, AddRestaurantParams> {
  final IRestaurantRepository _repository;
  AddRestaurant(IRestaurantRepository repository) : _repository = repository;
  @override
  Future<OneOf<Failure, Restaurant>> run(AddRestaurantParams params) =>
      _repository.addRestaurant(params);
}
