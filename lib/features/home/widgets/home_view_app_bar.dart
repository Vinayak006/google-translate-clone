import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";
import "../controllers/home_view_controller.dart";

class HomeViewAppBar extends GetView<HomeViewController>
    implements PreferredSizeWidget {
  const HomeViewAppBar({super.key});

  @override
  Widget build(final BuildContext context) => Stack(
        children: <Widget>[
          Obx(
            () => AnimatedOpacity(
              duration: 100.milliseconds,
              opacity: controller.firstChildOpacity.value,
              child: AppBar(
                backgroundColor: context.theme.colorScheme.surface,
                scrolledUnderElevation: 0,
                leading: const Icon(
                  Icons.star,
                  size: 24,
                ),
                centerTitle: true,
                title: RichText(
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Google",
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.colorScheme.scrim,
                        ),
                      ),
                      const TextSpan(text: "  "),
                      TextSpan(
                        text: "Translate",
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: context.theme.colorScheme.scrim.withAlpha(230),
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.theme.colorScheme.inverseSurface,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: Icon(
                        Icons.person_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                  const Gap(16),
                ],
              ),
            ),
          ),
          Obx(
            () => AnimatedOpacity(
              opacity: controller.secondChildOpacity.value,
              duration: 100.milliseconds,
              child: AppBar(
                backgroundColor: context.theme.colorScheme.surfaceContainer,
                scrolledUnderElevation: 0,
                leading: const Icon(
                  Icons.arrow_back_rounded,
                  size: 24,
                ),
                titleSpacing: 0,
                title: const Text("History"),
                actions: <Widget>[
                  PopupMenuButton<String>(
                    itemBuilder: (final BuildContext context) =>
                        <PopupMenuEntry<String>>[],
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
