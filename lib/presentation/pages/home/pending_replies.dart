import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/presentation/view_model/home/pending_replies_vm.dart';
import 'package:toptal_test/presentation/widgets/review_card.dart';

class PendingRepliesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PendingRepliesVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return Scaffold(
      body: SmartRefresher(
        controller: vm.refreshController,
        onRefresh: () => vm.loadPendingReplies(),
        child: ListView.separated(
          itemBuilder: (context, index) =>
              ReviewCardWidget(vm.pendingReplies[index]),
          separatorBuilder: (context, index) => Divider(),
          itemCount: vm.pendingReplies.length,
        ),
      ),
    );
  }
}
