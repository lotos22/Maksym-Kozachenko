import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/restaurant_details.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class GetRestaurantDetails
    extends UseCase<RestaurantDetails, GetRestaurantDetailsParams> {
  final IRestaurantRepository _repository;
  GetRestaurantDetails(IRestaurantRepository repository)
      : _repository = repository;

  @override
  Future<OneOf<Failure, RestaurantDetails>> run(
          GetRestaurantDetailsParams params) =>
      _repository.getRestaurantDetails(params);
}
