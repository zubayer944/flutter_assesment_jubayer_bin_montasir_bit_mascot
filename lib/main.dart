import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/config/app_config.dart';
import 'core/config/app_routes.dart';
import 'core/config/app_theme.dart';
import 'core/constants/app_sizes.dart';
import 'core/network/api_client.dart';
import 'core/storage/storage_service.dart';
import 'shared/services/auth_service.dart';
import 'features/auth/presentation/bindings/auth_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize app configuration
  AppConfig.initialize(
    env: Environment.dev,
    apiUrl: 'https://api.example.com',
  );

  // Initialize services
  await Get.putAsync(() => StorageService().init());
  Get.put(ApiClient.instance);
  Get.put(AuthService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: AppConfig.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.getPages,
          initialBinding: AuthBinding(),
          defaultTransition: Transition.fade,
          builder: (context, child) {
            // Initialize AppSizes with MediaQuery
            AppSizes.init(context);
            return child!;
          },
        );
      },
    );
  }
}
