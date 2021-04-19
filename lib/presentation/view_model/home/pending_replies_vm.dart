import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/review.dart';
import 'package:toptal_test/domain/interactor/restaurant/get_pending_replies.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class PendingRepliesVM extends BaseVM {
  final GetPendingReplies _getPendingReplies;
  PendingRepliesVM(
    GetPendingReplies getPendingReplies,
    AppLocalizations appLocalizations,
  )   : _getPendingReplies = getPendingReplies,
        super(appLocalizations);

  RefreshController refreshController = RefreshController();

  bool isInitialLoad = false;
  void initialLoading() {
    if (!isInitialLoad) {
      isInitialLoad = true;
      loadPendingReplies();
    }
  }

  List<Review> _pendingReplies = [];
  List<Review> get pendingReplies => _pendingReplies;

  void loadPendingReplies() async {
    await refreshController.requestRefresh();
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
