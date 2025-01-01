import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";
import "../controllers/home_view_controller.dart";
import "../controllers/language_controller.dart";

class BottomArea extends StatelessWidget {
  BottomArea({super.key});
  final GlobalKey<State<StatefulWidget>> targetKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> sourceKey = GlobalKey();

  @override
  Widget build(final BuildContext context) => Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: LanguageSwapSection(
                    targetKey: targetKey,
                    sourceKey: sourceKey,
                  ),
                ),
                const Gap(16),
                const Expanded(
                  flex: 2,
                  child: BottomActionButtons(),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: GetBuilder<HomeViewController>(
              id: "action-overlay",
              builder: (final HomeViewController controller) {
                final double overlayOpacity = (controller.totalMainHeight -
                        controller.currentMainHeight) /
                    controller.totalMainHeight;
                return overlayOpacity == 0
                    ? const SizedBox.shrink()
                    : ColoredBox(
                        color: Colors.black12.withValues(alpha: overlayOpacity),
                      );
              },
            ),
          ),
        ],
      );
}

class LanguageSwapSection extends GetView<LanguageController> {
  const LanguageSwapSection({
    required this.targetKey,
    required this.sourceKey,
    super.key,
  });
  final GlobalKey<State<StatefulWidget>> targetKey;
  final GlobalKey<State<StatefulWidget>> sourceKey;

  @override
  Widget build(final BuildContext context) => Row(
        children: <Widget>[
          Expanded(
            child: AnimatedBuilder(
              animation: controller.langAnimation,
              builder: (final BuildContext context, final Widget? child) =>
                  Transform.translate(
                offset: Offset(controller.langAnimation.value, 0),
                child: child,
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (final DragUpdateDetails details) {
                  final String temp = (controller
                              .langAnimationController.value +
                          details.delta.dx / controller.langAnimationEndValue)
                      .toStringAsFixed(2);
                  controller.langAnimationController.value = double.parse(temp);
                },
                onHorizontalDragEnd: (final DragEndDetails details) {
                  if (controller.langAnimation.value >
                      controller.langAnimationEndValue / 2) {
                    controller.langAnimationController.forward();
                  } else {
                    controller.langAnimationController.reverse();
                  }
                },
                onLongPressMoveUpdate:
                    (final LongPressMoveUpdateDetails details) {
                  final RenderBox renderBox =
                      context.findRenderObject()! as RenderBox;
                  final Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  controller.setHighlightedIndex(localPosition.dy);
                },
                onLongPressStart: (final LongPressStartDetails details) {
                  final RenderBox renderBox = sourceKey.currentContext!
                      .findRenderObject()! as RenderBox;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  final Size size = renderBox.size;
                  controller.showActions(
                    left: offset.dx,
                    top: offset.dy,
                    width: size.width,
                    height: size.height,
                    isTargetLanguage: false,
                  );
                },
                onLongPressEnd: (final LongPressEndDetails details) {
                  controller.hideActions(isTargetLanguage: false);
                },
                child: DecoratedBox(
                  key: sourceKey,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Obx(
                        () => Text(controller.sourceLang.value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: controller.onSwapTap,
            icon: const Icon(Icons.swap_horiz_rounded),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: controller.langAnimation,
              builder: (final BuildContext context, final Widget? child) =>
                  Transform.translate(
                offset: Offset(-controller.langAnimation.value, 0),
                child: child,
              ),
              child: GestureDetector(
                onHorizontalDragUpdate: (final DragUpdateDetails details) {
                  final String temp = (controller
                              .langAnimationController.value -
                          details.delta.dx / controller.langAnimationEndValue)
                      .toStringAsFixed(2);
                  controller.langAnimationController.value = double.parse(temp);
                },
                onHorizontalDragEnd: (final DragEndDetails details) {
                  if (controller.langAnimation.value >
                      controller.langAnimationEndValue / 2) {
                    controller.langAnimationController.forward();
                  } else {
                    controller.langAnimationController.reverse();
                  }
                },
                onLongPressMoveUpdate:
                    (final LongPressMoveUpdateDetails details) {
                  final RenderBox renderBox =
                      context.findRenderObject()! as RenderBox;
                  final Offset localPosition =
                      renderBox.globalToLocal(details.globalPosition);
                  controller.setHighlightedIndex(localPosition.dy);
                },
                onLongPressStart: (final LongPressStartDetails details) {
                  final RenderBox renderBox = targetKey.currentContext!
                      .findRenderObject()! as RenderBox;
                  final Offset offset = renderBox.localToGlobal(Offset.zero);
                  final Size size = renderBox.size;
                  controller.showActions(
                    left: offset.dx,
                    top: offset.dy,
                    width: size.width,
                    height: size.height,
                    isTargetLanguage: true,
                  );
                },
                onLongPressEnd: (final LongPressEndDetails details) {
                  controller.hideActions(isTargetLanguage: true);
                },
                child: DecoratedBox(
                  key: targetKey,
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: Obx(
                        () => Text(controller.targetLang.value),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({super.key});

  @override
  Widget build(final BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ActionButton(
            icon: Icons.people_alt_outlined,
            dimension: 45,
            backgroundColor: context.theme.colorScheme.primaryContainer,
            foregroundColor: context.theme.colorScheme.onPrimaryContainer,
          ),
          ActionButton(
            icon: Icons.mic_none_sharp,
            dimension: 85,
            backgroundColor: context.theme.colorScheme.secondaryContainer,
            foregroundColor: context.theme.colorScheme.onSecondaryContainer,
          ),
          ActionButton(
            icon: Icons.camera_enhance_outlined,
            dimension: 45,
            backgroundColor: context.theme.colorScheme.primaryContainer,
            foregroundColor: context.theme.colorScheme.onPrimaryContainer,
          ),
        ],
      );
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.dimension,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
  });
  final IconData icon;
  final double dimension;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(final BuildContext context) => SizedBox.square(
        dimension: dimension,
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: const CircleBorder(),
          child: Icon(
            icon,
            size: dimension / 2,
          ),
        ),
      );
}
