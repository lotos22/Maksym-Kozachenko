import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/user/get_users.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';

@injectable
class UsersVM extends BaseVM {
  final GetUsers _getUsers;

  UsersVM(
    GetUsers getUsers,
    AppLocalizations appLocalizations,
  )   : _getUsers = getUsers,
        super(appLocalizations);

  RefreshController refreshController = RefreshController();

  bool isInitialLoad = false;
  void initialLoading() {
    if (!isInitialLoad) {
      isInitialLoad = true;
      loadUsers();
    }
  }

  List<AppUser> _users = [];
  List<AppUser> get users => _users;

  bool isUserLoading = false;
  void loadUsers() async {
    await refreshController.requestRefresh();
    await _getUsers.execute(null, (oneOf) {
      if (oneOf.isSuccess) {
        _users = (oneOf as Success).data;
      }
      refreshController.refreshCompleted();
      notifyListeners();
    });
  }
}
