import "package:flutter/material.dart";
import "package:get/get.dart";

class HandleBar extends StatelessWidget {
  const HandleBar({
    super.key,
  });

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: 50,
          height: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
      );
}
