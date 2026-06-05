import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:morla/core/services/auth_token_storage_service.dart';

class AppApiClient {
  final Dio dio;

  AppApiClient._(this.dio);

  factory AppApiClient.create({
    required AuthTokenStorageService tokenStorageService,
  }) {
    const baseUrl = String.fromEnvironment(
      'API_BASE_URL',
      // defaultValue: 'http://10.0.2.2:3000/api',
      defaultValue: 'https://morla-api.onrender.com/api',
    );

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }

    return AppApiClient._(dio);
  }
}
