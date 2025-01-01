import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class HomeViewController extends GetxController {
  late double currentMainHeight;
  late final double totalMainHeight;

  void handlePointerUp() {
    if (!ignoreHistoryList) {
      return;
    }
    currentMainHeight =
        currentMainHeight > totalMainHeight * 0.5 ? totalMainHeight : 0;
    firstChildOpacity.value = currentMainHeight == 0 ? 0 : 1;
    secondChildOpacity.value = currentMainHeight != 0 ? 0 : 1;
    final bool tempIgnoreState = secondChildOpacity.value == 0;
    if (ignoreHistoryList != tempIgnoreState) {
      ignoreHistoryList = tempIgnoreState;
    }
    update(<Object>["main-area", "action-overlay"]);
  }

  void handlePointerMove(final double pos) {
    if (!ignoreHistoryList) {
      return;
    }
    final double tempTop = currentMainHeight - pos;
    currentMainHeight = tempTop.clamp(0, totalMainHeight);
    final double tempOpacity =
        (totalMainHeight * 0.5 - currentMainHeight) / totalMainHeight;
    if (tempOpacity.isNegative) {
      firstChildOpacity.value = tempOpacity.abs() * 2;
      if (secondChildOpacity.value != 0) {
        secondChildOpacity.value = 0;
      }
    } else {
      if (firstChildOpacity.value != 0) {
        firstChildOpacity.value = 0;
      }
      secondChildOpacity.value = tempOpacity * 2;
    }
    update(<Object>["main-area", "action-overlay"]);
  }

  RxDouble firstChildOpacity = 1.0.obs;
  RxDouble secondChildOpacity = 0.0.obs;

  final RxBool _ignoreHistoryList = true.obs;
  bool get ignoreHistoryList => _ignoreHistoryList.value;
  set ignoreHistoryList(final bool value) => _ignoreHistoryList.value = value;

  void handleIgnoreHistoryList(final ScrollNotification notification) {
    if (notification.metrics.pixels == 0) {
      if (!ignoreHistoryList) {
        ignoreHistoryList = true;
      }
    } else {
      if (ignoreHistoryList) {
        ignoreHistoryList = false;
      }
    }
  }

  String clipboardText = "";

  Future<void> checkForClipboardText() async {
    final ClipboardData? clipboardData = await Clipboard.getData("text/plain");
    if (clipboardData != null) {
      clipboardText = clipboardData.text!;
      update(<Object>["paste-area"]);
    }
  }

  @override
  void onInit() {
    currentMainHeight = totalMainHeight = (Get.height - 32 - 56) * 0.3;
    unawaited(checkForClipboardText());
    super.onInit();
  }
}
