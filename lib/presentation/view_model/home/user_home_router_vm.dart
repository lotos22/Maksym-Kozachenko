import 'package:injectable/injectable.dart';
import 'package:toptal_test/domain/login/sign_out.dart';
import 'package:toptal_test/presentation/view_model/base_vm.dart';

@injectable
class UserHomeRouterVM extends BaseVM {
  final SignOut _signOut;

  UserHomeRouterVM(SignOut signOut) : _signOut = signOut;

  bool signOutLoading = false;

  void signOut() {
    signOutLoading = true;
    notifyListeners();
    _signOut.execute(null, (oneOf) {
      signOutLoading = false;
      notifyListeners();
    });
  }
}
