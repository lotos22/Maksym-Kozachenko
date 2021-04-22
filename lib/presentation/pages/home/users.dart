import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/repository/params.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/edit_user_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/users_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_modal.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UsersVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return LoadingModalWidget(
      loading: vm.isUserLoading,
      child: Scaffold(
        body: SmartRefresher(
          onRefresh: () => vm.loadUsers(),
          controller: vm.refreshController,
          child: ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text(vm.users[index].id),
              subtitle: Text(
                '${vm.users[index].userRole.toString()} ${vm.users[index].email?.toString()}',
              ),
              onLongPress: () => showDialog(
                context: context,
                builder: (context) => EditUserDialog(vm.users[index]),
              ).then((value) {
                if (value is DeleteUserParams) {
                  vm.deleteUser(value);
                }
                if (value is UpdateUserParams) {
                  vm.updateUser(value);
                }
              }),
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: vm.users.length,
          ),
        ),
      ),
    );
  }
}
