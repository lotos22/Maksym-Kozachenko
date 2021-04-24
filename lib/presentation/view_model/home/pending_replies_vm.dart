import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/domain/interactor/review/add_reply.dart';
import 'package:toptal_test/domain/interactor/review/get_pending_replies.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/const.dart';
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
        super(appLocalizations){
           pagingController.addPageRequestListener((pageKey) {
        loadPendingReplies();
      });
        }

  RefreshController refreshController = RefreshController();


  PagingController<int, PendingReply> pagingController =
      PagingController(firstPageKey: 0);

  bool isAddingReply = false;
  void addReply(PendingReply pendingReply, String reply) {
    if (reply.trim().isNotEmpty) ;
    isAddingReply = true;
    notifyListeners();
    _addReply.execute(
        AddReplyParams(reply, pendingReply.restId, pendingReply.id), (oneOf) {
      if (oneOf.isSuccess) {
        // _pendingReplies.remove(pendingReply);
      }
      isAddingReply = false;
      notifyListeners();
    });
  }

  void loadPendingReplies() async {
    final pageKey = pagingController.nextPageKey ?? 0;
    final params = GetPendingRepliesParams(
      page: pageKey,
      pageSize: PageSize.pageSize,
    );
    await _getPendingReplies.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final data = (oneOf as Success).data as List<PendingReply>;
        if (data.length == PageSize.pageSize) {
          pagingController.appendPage(data, pageKey + 1);
        } else {
          pagingController.appendLastPage(data);
        }
      } else {
        sendMessage(appLocalizations.something_went_wrong);
        pagingController.appendLastPage([]);
      }
      refreshController.refreshCompleted();
      runCatching(() {
        notifyListeners();
      });
    });
  }
}
