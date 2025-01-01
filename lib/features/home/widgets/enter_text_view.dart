import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";

import "../controllers/home_view_controller.dart";

class EnterTextView extends StatelessWidget {
  const EnterTextView({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Gap((Get.height - 32 - 56) * 0.36),
            Text(
              "Enter text",
              style: context.theme.textTheme.displaySmall,
            ),
            GetBuilder<HomeViewController>(
              id: "paste-area",
              builder: (final HomeViewController controller) {
                if (controller.clipboardText.isEmpty) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Gap(48),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            context.theme.colorScheme.primaryContainer,
                        foregroundColor:
                            context.theme.colorScheme.onPrimaryContainer,
                        iconColor: context.theme.colorScheme.onPrimaryContainer,
                        iconSize: context.theme.textTheme.bodyLarge?.fontSize,
                        textStyle: context.theme.textTheme.bodyMedium,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 18,
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.paste_rounded),
                      label: const Text("Paste"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
}
