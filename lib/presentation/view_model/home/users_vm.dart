import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/restaurant.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/user/delete_user.dart';
import 'package:toptal_test/domain/interactor/user/get_users.dart';
import 'package:toptal_test/domain/interactor/user/update_user.dart';
import 'package:toptal_test/domain/one_of.dart';
import 'package:toptal_test/domain/repository/params.dart';

import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/const.dart';
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
  void initialLoading() async {
    if (!isInitialLoad) {
      loadUsers();
      isInitialLoad = true;
      pagingController.addPageRequestListener((pageKey) {
        loadUsers();
      });
    }
  }

  bool isUserLoading = false;

  PagingController<String?, AppUser> pagingController =
      PagingController(firstPageKey: null);

  void loadUsers() async {
    final pageKey = pagingController.nextPageKey;
    final params = GetUsersParams(
      lastDocId: pageKey,
      pageSize: PageSize.pageSize,
    );
    await _getUsers.execute(params, (oneOf) {
      if (oneOf.isSuccess) {
        final data = (oneOf as Success).data as List<AppUser>;
        if (data.length == PageSize.pageSize) {
          pagingController.appendPage(data, data.last.id);
        } else {
          pagingController.appendLastPage(data);
        }
      } else {
        sendMessage(appLocalizations.something_went_wrong);
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

  void refreshItems() {
    pagingController.refresh();
  }
}
