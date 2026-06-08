import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:billkit/core/theme/app_theme.dart';
import 'package:billkit/routes/app_pages.dart';
import 'package:billkit/routes/app_routes.dart';
import 'package:billkit/core/services/app_prefs_service.dart';
import 'package:billkit/core/services/network_connectivity_service.dart';
import 'package:billkit/core/services/socket_service.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/core/services/auth_token_storage_service.dart';
import 'package:billkit/core/services/google_auth_service.dart';
import 'package:billkit/features/announcements/controllers/announcements_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize core services
  await Get.putAsync(() => AppPrefsService().init());
  Get.put(NetworkConnectivityService());

  // Initialize auth and API services
  const tokenStorage = AuthTokenStorageService();
  Get.put<AuthTokenStorageService>(tokenStorage);

  final apiClient = AppApiClient.create(tokenStorageService: tokenStorage);
  Get.put<AppApiClient>(apiClient);

  // Initialize Google Auth service
  await Get.putAsync(() => GoogleAuthService().init());

  // Initialize Socket service
  await Get.putAsync(() => SocketService().init());

  // Initialize announcement controller
  Get.put(AnnouncementsController());

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
