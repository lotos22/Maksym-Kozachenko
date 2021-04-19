import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/enter_message_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/pending_replies_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_modal.dart';
import 'package:toptal_test/presentation/widgets/review_card.dart';
import 'package:toptal_test/utils/localizations.dart';

class PendingRepliesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PendingRepliesVM>(context);

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      vm.initialLoading();
    });

    return LoadingModalWidget(
      loading: vm.isAddingReply,
      child: Scaffold(
        body: SmartRefresher(
          controller: vm.refreshController,
          onRefresh: () => vm.loadPendingReplies(),
          child: ListView.builder(
            itemBuilder: (context, index) => ReviewCardWidget(
              vm.pendingReplies[index],
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => EnterMessageDialog(
                    AppLocalizations.of(context).restaurant_details_reply,
                  ),
                ).then((value) {
                  if (value != null && value is String) {
                    vm.addReply(vm.pendingReplies[index], value);
                  }
                });
              },
            ),
            itemCount: vm.pendingReplies.length,
          ),
        ),
      ),
    );
  }
}
