import "package:flutter/material.dart";
import "package:get/get.dart";
import "config/routes.dart";
import "config/themes.dart";
import "features/home/home_view.dart";

class GoogleTranslateCloneApp extends StatelessWidget {
  const GoogleTranslateCloneApp({super.key});

  @override
  Widget build(final BuildContext context) => GetMaterialApp(
        theme: AppThemes().lightTheme,
        darkTheme: AppThemes().darkTheme,
        getPages: AppRoutes().routes,
        initialRoute: HomeView.route,
        debugShowCheckedModeBanner: false,
      );
}
