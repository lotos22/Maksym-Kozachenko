import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/user/delete_user.dart';
import 'package:toptal_test/domain/interactor/user/get_users.dart';
import 'package:toptal_test/domain/interactor/user/update_user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class UsersVM extends BaseVM {
  final GetUsers _getUsers;
  final DeleteUser _deleteUser;
  final UpdateUser _updateUser;

  UsersVM(
    GetUsers getUsers,
    DeleteUser deleteUser,
    UpdateUser updateUser,
    AppLocalizations appLocalizations,
  )   : _getUsers = getUsers,
        _deleteUser = deleteUser,
        _updateUser = updateUser,
        super(appLocalizations);

  RefreshController refreshController = RefreshController();

  bool isInitialLoad = false;
  void initialLoading() async{
    if (!isInitialLoad) {
      await refreshController.requestRefresh();
      isInitialLoad = true;
    }
  }

  List<AppUser> _users = [];
  List<AppUser> get users => _users;

  bool isUserLoading = false;

  void loadUsers() async {
    await _getUsers.execute(null, (oneOf) {
      if (oneOf.isSuccess) {
        _users = (oneOf as Success).data;
      }
      refreshController.refreshCompleted();
      runCatching(() {
        notifyListeners();
      });
    });
  }

  void updateUser(UpdateUserParams params) {
    isUserLoading = true;
    notifyListeners();
    _updateUser.execute(params, (oneOf) {
      if (oneOf.isSuccess) loadUsers();
      isUserLoading = false;
      notifyListeners();
    });
  }

  void deleteUser(DeleteUserParams params) {
    isUserLoading = true;
    notifyListeners();
    _deleteUser.execute(params, (oneOf) {
      if (oneOf.isSuccess) loadUsers();
      isUserLoading = false;
      notifyListeners();
    });
  }
}
