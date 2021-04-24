import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toptal_test/domain/entities/pendingReply.dart';
import 'package:toptal_test/presentation/pages/home/dialogs/enter_message_dialog.dart';
import 'package:toptal_test/presentation/view_model/home/pending_replies_vm.dart';
import 'package:toptal_test/presentation/widgets/loading_modal.dart';
import 'package:toptal_test/presentation/widgets/review_card.dart';
import 'package:toptal_test/presentation/widgets/toast_widget.dart';
import 'package:toptal_test/utils/localizations.dart';

class PendingRepliesPage extends StatefulWidget {
  @override
  _PendingRepliesPageState createState() => _PendingRepliesPageState();
}

class _PendingRepliesPageState extends State<PendingRepliesPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final vm = Provider.of<PendingRepliesVM>(context);

    return LoadingModalWidget(
      loading: vm.isAddingReply,
      child: ToastWidget(
        toast: vm.toast,
        child: Scaffold(
          body: SmartRefresher(
            controller: vm.refreshController,
            onRefresh: () => vm.pagingController.refresh(),
            child: PagedListView<int, PendingReply>(
              pagingController: vm.pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, item, index) => ReviewCardWidget(
                  item,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => EnterMessageDialog(
                        AppLocalizations.of(context).restaurant_details_reply,
                      ),
                    ).then((value) {
                      if (value != null && value is String) {
                        vm.addReply(item, value);
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
