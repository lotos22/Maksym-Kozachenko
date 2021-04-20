import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/presentation/view_model/home/users_vm.dart';

class UsersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UsersVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return Scaffold(
      body: SmartRefresher(
        onRefresh: () => vm.loadUsers(),
        controller: vm.refreshController,
        child: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            title: Text(vm.users[index].id),
            subtitle: Text(vm.users[index].userRole.toString()),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: vm.users.length,
        ),
      ),
    );
  }
}
