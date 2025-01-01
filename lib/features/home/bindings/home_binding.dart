import "package:get/get.dart";

import "../controllers/home_view_controller.dart";
import "../controllers/language_controller.dart";

class HomeViewBinding implements Bindings {
  @override
  void dependencies() {
    Get
      ..put<LanguageController>(LanguageController())
      ..put<HomeViewController>(HomeViewController());
  }
}
