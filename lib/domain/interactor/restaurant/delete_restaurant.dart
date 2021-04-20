import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';
import 'package:toptal_test/domain/params.dart';

@injectable
class DeleteRestaurant extends UseCase<Null, DeleteRestaurantParams> {
  final IRestaurantRepository _repository;
  DeleteRestaurant(IRestaurantRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, Null>> run(DeleteRestaurantParams params) =>
      _repository.deleteRestaurant(params);
}
