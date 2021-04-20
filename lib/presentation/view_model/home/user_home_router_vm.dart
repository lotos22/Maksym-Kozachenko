import 'package:injectable/injectable.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/interactor/login/sign_out.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';
import 'package:toptal_test/utils/localizations.dart';
import 'package:toptal_test/utils/utils.dart';

@injectable
class UserHomeRouterVM extends BaseVM {
  final SignOut _signOut;

  UserHomeRouterVM(
    AppLocalizations appLocalizations,
    SignOut signOut,
  )   : _signOut = signOut,
        super(appLocalizations);

  bool isSignOutLoading = false;
  bool isRoleLoading = false;

  bool isGetRoleError = false;

  UserRole? get getRole => getIt.getSafe<AppUser>()?.userRole;



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
