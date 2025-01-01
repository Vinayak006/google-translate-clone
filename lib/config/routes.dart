import "package:get/get.dart";

import "../features/home/bindings/home_binding.dart";
import "../features/home/home_view.dart";

class AppRoutes {
  List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: HomeView.route,
      page: HomeView.new,
      binding: HomeViewBinding(),
    ),
  ];
}
