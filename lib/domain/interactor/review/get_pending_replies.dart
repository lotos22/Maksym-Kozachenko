import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/repository/i_review_repository.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/domain/use_case.dart';

@injectable
class GetPendingReplies
    extends UseCase<List<PendingReply>, GetPendingRepliesParams> {
  final IReviewRepository _repository;
  GetPendingReplies(IReviewRepository repository) : _repository = repository;

  @override
  Future<OneOf<Failure, List<PendingReply>>> run(
          GetPendingRepliesParams params) =>
      _repository.getPendingReplies(params);
}
