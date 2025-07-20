import 'package:get/get.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/bindings/auth_binding.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/details/presentation/pages/details_page.dart';
import '../../features/details/presentation/bindings/details_binding.dart';
import '../utils/splash_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String details = '/details';

  static List<GetPage> getPages = [
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fade,
    ),
    GetPage(
      name: details,
      page: () => const DetailsPage(),
      binding: DetailsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];

  static void navigateToSplash() => Get.offAllNamed(splash);
  static void navigateToLogin() => Get.offAllNamed(login);
  static void navigateToHome() => Get.offAllNamed(home);
  static void navigateToDetails(dynamic arguments) => Get.toNamed(details, arguments: arguments);
} 