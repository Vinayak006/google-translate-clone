import "package:flutter/material.dart";
import "package:get/get.dart";
import "../controllers/language_controller.dart";

class LanguageActionWidget extends GetView<LanguageController> {
  const LanguageActionWidget({super.key});

  @override
  Widget build(final BuildContext context) => Obx(
        () => controller.showActionArea.isFalse
            ? Container()
            : const LanguageActionArea(),
      );
}

class LanguageActionArea extends GetView<LanguageController> {
  const LanguageActionArea({super.key});

  @override
  Widget build(final BuildContext context) {
    final bool isTargetLanguage = controller.actionArea!.$5;
    final List<String> recentLanguages = isTargetLanguage
        ? controller.recentLanguagesForTarget
        : controller.recentLanguagesForSource;
    final String currentLanguage = isTargetLanguage
        ? controller.targetLang.value
        : controller.sourceLang.value;

    return Obx(
      () => AnimatedPositioned(
        left: controller.actionArea!.$1,
        top: controller.showLanguageOptions.value
            ? controller.actionArea!.$2 -
                56 -
                32 -
                (controller.actionArea!.$4 * recentLanguages.length)
            : controller.actionArea!.$2 - 56 - 32,
        duration: 300.milliseconds,
        curve: Curves.easeIn,
        child: AnimatedContainer(
          curve: Curves.easeIn,
          width: controller.actionArea!.$3,
          height: controller.showLanguageOptions.value
              ? controller.actionArea!.$4 * (recentLanguages.length + 2)
              : controller.actionArea!.$4,
          duration: 300.milliseconds,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.theme.colorScheme.surfaceContainerHigh,
          ),
          child: controller.showLanguageOptions.value
              ? Column(
                  children: <Widget>[
                    for (final String lang in recentLanguages)
                      Expanded(
                        child: LanguageTile(
                          language: lang,
                          isHighlighted: lang == controller.hoveringLang.value,
                        ),
                      ),
                    SizedBox(
                      height: controller.actionArea!.$4,
                      child: LanguageTile(
                        language: currentLanguage,
                        isHighlighted:
                            currentLanguage == controller.hoveringLang.value,
                      ),
                    ),
                    Expanded(
                      child: LanguageTile(
                        language: "More\nLanguage",
                        isHighlighted: "MORE" == controller.hoveringLang.value,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    for (final String lang in recentLanguages)
                      if (controller.hoveringLang.value == lang)
                        SizedBox(
                          height: controller.actionArea!.$4,
                          child: LanguageTile(
                            language: lang,
                            isHighlighted:
                                lang == controller.hoveringLang.value,
                          ),
                        )
                      else
                        Expanded(
                          child: LanguageTile(
                            language: lang,
                            isHighlighted:
                                lang == controller.hoveringLang.value,
                          ),
                        ),
                    if (controller.hoveringLang.value == currentLanguage)
                      SizedBox(
                        height: controller.actionArea!.$4,
                        child: LanguageTile(
                          language: currentLanguage,
                          isHighlighted: currentLanguage ==
                                  controller.hoveringLang.value &&
                              controller.showLanguageOptions.isTrue,
                        ),
                      )
                    else
                      Expanded(
                        child: LanguageTile(
                          language: currentLanguage,
                          isHighlighted:
                              currentLanguage == controller.hoveringLang.value,
                        ),
                      ),
                    Expanded(
                      child: LanguageTile(
                        language: "More\nLanguage",
                        isHighlighted: "MORE" == controller.hoveringLang.value,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  const LanguageTile({
    required this.language,
    required this.isHighlighted,
    super.key,
  });
  final String language;
  final bool isHighlighted;

  @override
  Widget build(final BuildContext context) => AnimatedContainer(
        margin: const EdgeInsets.all(4),
        duration: 300.milliseconds,
        decoration: BoxDecoration(
          color: isHighlighted
              ? context.theme.colorScheme.primaryContainer
              : context.theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            language,
            textAlign: TextAlign.center,
            style: language == "More\nLanguage"
                ? context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.theme.colorScheme.secondaryContainer,
                  )
                : null,
          ),
        ),
      );
}
