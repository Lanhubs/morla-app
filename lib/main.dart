import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morla/core/theme/app_theme.dart';
import 'package:morla/routes/app_pages.dart';
import 'package:morla/routes/app_routes.dart';
import 'package:morla/core/services/app_prefs_service.dart';
import 'package:morla/core/services/network_connectivity_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AppPrefsService().init());
  Get.put(NetworkConnectivityService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.darkTheme,
      darkTheme: AppThemes.lightTheme,
      themeMode: ThemeMode.dark,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}

