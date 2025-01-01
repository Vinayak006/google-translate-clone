import "package:flutter/material.dart";
import "package:get/get.dart";
import "../controllers/home_view_controller.dart";
import "enter_text_view.dart";
import "handle_bar.dart";
import "history_list_view.dart";

class MainArea extends GetView<HomeViewController> {
  const MainArea({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Listener(
        onPointerUp: (final PointerUpEvent event) {
          controller.handlePointerUp();
        },
        onPointerMove: (final PointerMoveEvent event) {
          controller.handlePointerMove(event.delta.dy);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Stack(
            children: <Widget>[
              Obx(
                () => AnimatedOpacity(
                  opacity: controller.firstChildOpacity.value,
                  duration: 100.milliseconds,
                  child: const EnterTextView(),
                ),
              ),
              Obx(
                () => AnimatedOpacity(
                  opacity: controller.secondChildOpacity.value,
                  duration: 100.milliseconds,
                  child: const HistoryListView(),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: HandleBar(),
              ),
            ],
          ),
        ),
      );
}
