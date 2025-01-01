import "package:flutter/material.dart";
import "package:get/get.dart";
import "../controllers/home_view_controller.dart";

class HistoryListView extends GetView<HomeViewController> {
  const HistoryListView({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Obx(
        () => IgnorePointer(
          ignoring: controller.ignoreHistoryList,
          child: NotificationListener<ScrollNotification>(
            onNotification: (
              final ScrollNotification notification,
            ) {
              controller.handleIgnoreHistoryList(
                notification,
              );
              return true;
            },
            child: ListView(
              reverse: true,
              physics: const ClampingScrollPhysics(),
              children: List<Widget>.generate(
                50,
                (final int index) => ListTile(
                  title: Text("Text $index"),
                ),
              ),
            ),
          ),
        ),
      );
}
