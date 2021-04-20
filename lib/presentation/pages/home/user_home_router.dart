import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/presentation/routes/user_routes.dart';
import 'package:toptal_test/presentation/view_model/home/user_home_router_vm.dart';
import 'package:toptal_test/presentation/widgets/animated_loading.dart';
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
          if (_userRouteDelegate.pageIndex == 0 &&
              _userRouteDelegate.isHomePage)
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      Text('1'),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                      )
                    ],
                  ),
                ),
              ],
            ),
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
      body: ChangeNotifierProvider.value(
        value: _userRouteDelegate,
        child: Router(
          routerDelegate: _userRouteDelegate,
          backButtonDispatcher: _backButtonDispatcher,
        ),
      ),
      bottomNavigationBar: getBottomBarForRole(vm.getRole, _userRouteDelegate),
    );
  }

  Widget? getBottomBarForRole(
      UserRole? getRole, UserRouteDelegate userRouteDelegate) {
    if (getRole == null) return null;
    if (getRole == UserRole.OWNER || getRole == UserRole.ADMIN) {
      return BottomNavigationBar(
        currentIndex: userRouteDelegate.pageIndex,
        onTap: (value) => userRouteDelegate.pageIndex = value,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rate_review),
            label: 'Pending replies',
          ),
          if (getRole == UserRole.ADMIN)
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Users',
            ),
        ],
      );
    }
  }
}
