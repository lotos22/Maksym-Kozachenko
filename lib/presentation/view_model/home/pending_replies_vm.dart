import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/interactor/review/add_reply.dart';
import 'package:toptal_test/domain/interactor/review/get_pending_replies.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class PendingRepliesVM extends BaseVM {
  final GetPendingReplies _getPendingReplies;
  final AddReply _addReply;
  PendingRepliesVM(
    AddReply addReply,
    GetPendingReplies getPendingReplies,
    AppLocalizations appLocalizations,
  )   : _getPendingReplies = getPendingReplies,
        _addReply = addReply,
        super(appLocalizations);

  RefreshController refreshController = RefreshController();

  bool isInitialLoad = false;
  void initialLoading() async {
    if (!isInitialLoad) {
      await refreshController.requestRefresh();
      isInitialLoad = true;
    }
  }

  List<PendingReply> _pendingReplies = [];
  List<PendingReply> get pendingReplies => _pendingReplies;

  bool isAddingReply = false;
  void addReply(PendingReply pendingReply, String reply) {
    if (reply.trim().isNotEmpty) ;
    isAddingReply = true;
    notifyListeners();
    _addReply
        .execute(AddReplyParams(reply, pendingReply.restId, pendingReply.docId),
            (oneOf) {
      if (oneOf.isSuccess) {
        _pendingReplies.remove(pendingReply);
      }
      isAddingReply = false;
      notifyListeners();
    });
  }

  void loadPendingReplies() async {
    await _getPendingReplies.execute(null, (oneOf) {
      if (oneOf.isSuccess) {
        _pendingReplies = (oneOf as Success).data;
      }
      refreshController.refreshCompleted();
      runCatching(() {
        notifyListeners();
      });
    });
  }
}
