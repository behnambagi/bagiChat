import 'package:get/get_navigation/src/routes/get_route.dart';

part 'app_routes.dart';

class AppPages {
  static const dashboard = Routes.dashboard;
  static const loginPage = Routes.login;
  static const home = Routes.home;
  static const profileAdmin = Routes.profileAdmin;
  static const splash = Routes.splash;
  static const addPark = Routes.addPark;
  static final routes = <GetPage<dynamic>>[
    // GetPage(name: home, page: () => HomeScreen()),
    // GetPage(name: addPark, page: () =>  const AddEditParkScreen()),
    // GetPage(name: splash, page: () =>  const SplashPage()),
    // GetPage(name: loginPage, page: () => LoginScreen()),
  ];
}
