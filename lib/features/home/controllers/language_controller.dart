import "package:flutter/animation.dart";
import "package:get/get.dart";

class LanguageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController langAnimationController;
  late Animation<double> langAnimation;
  late double langAnimationEndValue;

  (double, double, double, double, bool)? actionArea;

  RxString sourceLang = "English".obs;
  RxString targetLang = "Tamil".obs;

  RxString hoveringLang = "".obs;

  int _currentIndex = 0;

  List<String> recentLanguages = <String>[
    "English",
    "Telugu",
    "Tamil",
    "Spanish",
    "French",
    "Kanada",
  ];

  List<String> get recentLanguagesForTarget => recentLanguages
      .where((final String language) => language != targetLang.value)
      .toList();

  List<String> get recentLanguagesForSource => recentLanguages
      .where((final String language) => language != sourceLang.value)
      .toList();

  RxBool langSwapped = false.obs;

  RxBool showActionArea = false.obs;
  RxBool showLanguageOptions = false.obs;

  void showActions({
    required final double left,
    required final double top,
    required final double width,
    required final double height,
    required final bool isTargetLanguage,
  }) {
    actionArea = (left, top, width, height, isTargetLanguage);
    if (isTargetLanguage) {
      hoveringLang.value = targetLang.value;
    } else {
      hoveringLang.value = sourceLang.value;
    }
    showActionArea.value = true;
    Future<void>.delayed(100.milliseconds, () {
      showLanguageOptions.value = true;
    });
  }

  void setHighlightedIndex(final double dy) {
    final int newIndex = ((dy - 12) / actionArea!.$4).round();
    if (_currentIndex == newIndex) {
      return;
    }
    if (newIndex == 0) {
      _currentIndex = 0;
      hoveringLang.value = actionArea!.$5 ? targetLang.value : sourceLang.value;
    } else if (newIndex == 1) {
      _currentIndex = 1;
      hoveringLang.value = "MORE";
    } else if (newIndex.isNegative) {
      _currentIndex = newIndex;
      if (actionArea!.$5) {
        if (newIndex.abs() <= recentLanguagesForTarget.length) {
          final String temp = recentLanguagesForTarget[
              recentLanguagesForTarget.length + newIndex];
          if (temp != targetLang.value) {
            hoveringLang.value = temp;
          }
        }
      } else {
        if (newIndex.abs() <= recentLanguagesForSource.length) {
          final String temp = recentLanguagesForSource[
              recentLanguagesForSource.length + newIndex];
          if (temp != sourceLang.value) {
            hoveringLang.value = temp;
          }
        }
      }
    }
  }

  void resetHighlightedIndex() {
    hoveringLang.value = "";
    _currentIndex = 0;
  }

  String _getDifferentLangOtherThan(final String lang) =>
      recentLanguages.firstWhere((final String l) => l != lang);

  void hideActions({required final bool isTargetLanguage}) {
    showLanguageOptions.value = false;
    if (hoveringLang.value == "MORE") {
      hoveringLang.value =
          isTargetLanguage ? targetLang.value : sourceLang.value;
    }
    Future<void>.delayed(300.milliseconds, () {
      actionArea = null;
      showActionArea.value = false;
      if (isTargetLanguage) {
        if (targetLang.value != hoveringLang.value) {
          targetLang.value = hoveringLang.value;
          if (sourceLang.value == targetLang.value) {
            sourceLang.value = _getDifferentLangOtherThan(targetLang.value);
          }
        }
      } else {
        if (sourceLang.value != hoveringLang.value) {
          sourceLang.value = hoveringLang.value;
          if (targetLang.value == sourceLang.value) {
            targetLang.value = _getDifferentLangOtherThan(sourceLang.value);
          }
        }
      }
      resetHighlightedIndex();
    });
  }

  bool _sourceOnLeft = true;

  void onSwapTap() {
    if (langAnimation.isCompleted) {
      langAnimationController.reverse();
    } else {
      langAnimationController.forward();
    }
  }

  void swapLanguages() {
    langSwapped.value = !langSwapped.value;
    _sourceOnLeft = !_sourceOnLeft;
  }

  @override
  void onInit() {
    langAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    langAnimationEndValue = Get.width / 2 + 24 - 16;
    langAnimation = Tween<double>(begin: 0, end: langAnimationEndValue).animate(
      CurvedAnimation(
        parent: langAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    super.onInit();
  }

  @override
  void onClose() {
    langAnimationController.dispose();
    super.onClose();
  }
}
