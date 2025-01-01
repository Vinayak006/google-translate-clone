import "package:flutter/material.dart";
import "package:get/get.dart";
import "../controllers/home_view_controller.dart";
import "bottom_area.dart";
import "language_action_widget.dart";
import "main_area.dart";

class HomeBody extends GetView<HomeViewController> {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder: (
          final BuildContext context,
          final BoxConstraints constraints,
        ) =>
            Stack(
          children: <Widget>[
            Positioned.fill(
              child: ColoredBox(
                color: context.theme.colorScheme.surfaceContainer,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: constraints.maxHeight * 0.3,
              child: BottomArea(),
            ),
            GetBuilder<HomeViewController>(
              id: "main-area",
              builder: (final HomeViewController controller) =>
                  AnimatedPositioned(
                duration: 100.milliseconds,
                top: -controller.currentMainHeight,
                left: 0,
                right: 0,
                height: constraints.maxHeight,
                child: const MainArea(),
              ),
            ),
            const LanguageActionWidget(),
          ],
        ),
      );
}
