import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_restaurant_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class GetPendingReplies extends UseCase<List<PendingReply>, Null> {
  final IRestaurantRepository _repository;
  GetPendingReplies(IRestaurantRepository repository)
      : _repository = repository;

  @override
  Future<OneOf<Failure, List<PendingReply>>> run(Null params) =>
      _repository.getPendingReplies();
}
