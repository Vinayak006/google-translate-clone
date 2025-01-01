import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double t;
  late final double tt;

  double firstChildOpacity = 1;
  double secondChildOpacity = 0;

  bool langSwapped = false;

  bool ignoreHistoryList = true;

  @override
  void initState() {
    t = tt = (Get.height - 32 - 56) * 0.3;
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: context.theme.colorScheme.surface,
          title: const Text("Home"),
        ),
        body: LayoutBuilder(
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
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: LayoutBuilder(
                              builder: (
                                final BuildContext context,
                                final BoxConstraints constraints,
                              ) =>
                                  Stack(
                                children: <Widget>[
                                  AnimatedAlign(
                                    alignment: !langSwapped
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    duration: 300.milliseconds,
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              context.theme.colorScheme.surface,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Center(
                                            child: Text(
                                              "Tami.",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: context
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: context
                                                    .theme.colorScheme.scrim,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.2,
                                      child: Center(
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              langSwapped = !langSwapped;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.compare_arrows_rounded,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedAlign(
                                    alignment: !langSwapped
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    duration: 300.milliseconds,
                                    child: SizedBox(
                                      width: constraints.maxWidth * 0.4,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color:
                                              context.theme.colorScheme.surface,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Center(
                                            child: Text(
                                              "English",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: context
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: context
                                                    .theme.colorScheme.scrim,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Gap(16),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox.square(
                                  dimension: 50,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    heroTag: "1",
                                    elevation: 0,
                                    foregroundColor: context
                                        .theme.colorScheme.onPrimaryContainer,
                                    backgroundColor: context
                                        .theme.colorScheme.primaryContainer,
                                    shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.people_alt_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 90,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    heroTag: "2",
                                    elevation: 0,
                                    backgroundColor: context
                                        .theme.colorScheme.secondaryContainer,
                                    foregroundColor: context
                                        .theme.colorScheme.onSecondaryContainer,
                                    shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.mic_none_sharp,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                SizedBox.square(
                                  dimension: 50,
                                  child: FloatingActionButton(
                                    onPressed: () {},
                                    heroTag: "3",
                                    elevation: 0,
                                    foregroundColor: context
                                        .theme.colorScheme.onPrimaryContainer,
                                    backgroundColor: context
                                        .theme.colorScheme.primaryContainer,
                                    shape: const CircleBorder(),
                                    child: const Icon(
                                      Icons.camera_enhance_outlined,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: (tt - t) / tt == 0
                          ? const SizedBox.shrink()
                          : ColoredBox(
                              color: Colors.black12.withValues(
                                alpha: (tt - t) / tt,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              AnimatedPositioned(
                duration: 100.milliseconds,
                top: -t,
                left: 0,
                right: 0,
                height: constraints.maxHeight,
                child: Listener(
                  onPointerUp: (final PointerUpEvent event) {
                    if (!ignoreHistoryList) {
                      return;
                    }
                    setState(() {
                      t = t > tt * 0.5 ? tt : 0;
                      firstChildOpacity = t == 0 ? 0 : 1;
                      secondChildOpacity = t != 0 ? 0 : 1;
                      final bool tempIgnoreState = secondChildOpacity == 0;
                      if (ignoreHistoryList != tempIgnoreState) {
                        ignoreHistoryList = tempIgnoreState;
                      }
                    });
                  },
                  onPointerMove: (final PointerMoveEvent event) {
                    if (!ignoreHistoryList) {
                      return;
                    }
                    final double tempT = t - (event.delta.dy);
                    setState(() {
                      t = tempT.clamp(0, tt);
                      final double tempO = (tt * 0.5 - t) / tt;
                      if (tempO.isNegative) {
                        firstChildOpacity = tempO.abs() * 2;
                      } else {
                        secondChildOpacity = tempO * 2;
                      }
                    });
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
                        AnimatedOpacity(
                          opacity: firstChildOpacity,
                          duration: 100.milliseconds,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: constraints.maxHeight * 0.33,
                              left: 16,
                              right: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Gap(16),
                                Text(
                                  "Enter text",
                                  style: context.theme.textTheme.displaySmall,
                                ),
                                const Gap(48),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: context
                                        .theme.colorScheme.primaryContainer,
                                    foregroundColor: context
                                        .theme.colorScheme.onPrimaryContainer,
                                    iconColor: context
                                        .theme.colorScheme.onPrimaryContainer,
                                    iconSize: context
                                        .theme.textTheme.bodyLarge?.fontSize,
                                    textStyle:
                                        context.theme.textTheme.bodyMedium,
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
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: secondChildOpacity,
                          duration: 100.milliseconds,
                          child: IgnorePointer(
                            ignoring: ignoreHistoryList,
                            child: NotificationListener<ScrollNotification>(
                              onNotification:
                                  (final ScrollNotification notification) {
                                if (notification.metrics.pixels == 0) {
                                  if (!ignoreHistoryList) {
                                    setState(() {
                                      ignoreHistoryList = true;
                                    });
                                  }
                                } else {
                                  if (ignoreHistoryList) {
                                    setState(() {
                                      ignoreHistoryList = false;
                                    });
                                  }
                                }
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
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: SizedBox(
                              width: 50,
                              height: 5,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: context
                                      .theme.colorScheme.surfaceContainer,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
