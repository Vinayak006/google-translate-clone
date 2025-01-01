import "package:flutter/material.dart";

import "widgets/home_body.dart";
import "widgets/home_view_app_bar.dart";

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String route = "/home";

  @override
  Widget build(final BuildContext context) => const Scaffold(
        appBar: HomeViewAppBar(),
        body: HomeBody(),
      );
}
