import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/repository/failure.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/i_review_repository.dart';
import 'package:toptal_test/domain/use_case.dart';

import 'package:toptal_test/domain/params.dart';

@injectable
class AddReply extends UseCase<Null, AddReplyParams> {
  final IReviewRepository _repository;
  AddReply(IReviewRepository repository) : _repository = repository;
  @override
  Future<OneOf<Failure, Null>> run(AddReplyParams params) =>
      _repository.addReply(params);
}
