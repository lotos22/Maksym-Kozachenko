import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/di/injection_container.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/user_home_router_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_button.dart';
import 'package:toptal_test/utils/localizations.dart';

class UserHomeRouterPage extends StatefulWidget {
  @override
  _UserHomeRouterPageState createState() => _UserHomeRouterPageState();
}

class _UserHomeRouterPageState extends State<UserHomeRouterPage> {
  ChildBackButtonDispatcher? _backButtonDispatcher;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher!
        .createChildBackButtonDispatcher();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserHomeRouterVM>(context);
    final _userRouteDelegate = Provider.of<UserRouteDelegate>(context);
    return Scaffold(
      appBar: AppBar(
        leading: !_userRouteDelegate.isHomePage
            ? BackButton(
                onPressed: () {
                  _userRouteDelegate.popRoute();
                },
              )
            : null,
        actions: [
          AnimatedLoading(
            color: Colors.white,
            isLoading: vm.isSignOutLoading,
            child: IconButton(
              onPressed: () => vm.signOut(),
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: getIt.getSafe<AppUser>() == null
          ? Center(
              child: vm.isGetRoleError
                  ? ElevatedButton(
                      onPressed: () => vm.loadRole(),
                      child: Text(AppLocalizations.of(context).home_root_retry),
                    )
                  : CircularProgressIndicator(),
            )
          : ChangeNotifierProvider.value(
              value: _userRouteDelegate,
              child: Router(
                routerDelegate: _userRouteDelegate,
                backButtonDispatcher: _backButtonDispatcher,
              ),
            ),
    );
  }
}
