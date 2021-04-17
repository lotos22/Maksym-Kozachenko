import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/login/sign_out.dart';
import 'package:toptal_test/domain/user/get_user.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class UserHomeRouterVM extends BaseVM {
  final SignOut _signOut;
  final GetUser _getUserRole;
  UserHomeRouterVM(
    SignOut signOut,
    GetUser getUserRole,
  )   : _signOut = signOut,
        _getUserRole = getUserRole {
    loadRole();
  }

  bool isSignOutLoading = false;
  bool isRoleLoading = false;

  bool isGetRoleError = false;

  bool get isRoleLoaded => isGetRoleError && isRoleLoading;

  void loadRole() {
    isRoleLoading = true;
    notifyListeners();
    _getUserRole.execute(null, (oneOf) {
      runCatching(() {
        isGetRoleError = oneOf.isError;
        isRoleLoading = false;
        notifyListeners();
      });
    });
  }

  void signOut() {
    isSignOutLoading = true;
    notifyListeners();
    _signOut.execute(null, (oneOf) {
      runCatching(() {
        isSignOutLoading = false;
        notifyListeners();
      });
    });
  }
}
