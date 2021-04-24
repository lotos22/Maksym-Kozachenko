import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/user.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/edit_user_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/users_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_modal.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = Provider.of<UsersVM>(context);

    return ToastWidget(
      toast: vm.toast,
      child: LoadingModalWidget(
        loading: vm.isUserLoading,
        child: Scaffold(
          body: SmartRefresher(
            onRefresh: () => vm.pagingController.refresh(),
            controller: vm.refreshController,
            child: PagedListView<String?, AppUser>.separated(
              separatorBuilder: (context, index) => const Divider(),
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(item.id),
                  subtitle: Text(
                    '${item.userRole.toString()} ${item.email?.toString()}',
                  ),
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => EditUserDialog(item),
                  ).then((value) {
                    if (value is DeleteUserParams) {
                      vm.deleteUser(value);
                    }
                    if (value is UpdateUserParams) {
                      vm.updateUser(value);
                    }
                  }),
                ),
              ),
              pagingController: vm.pagingController,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
