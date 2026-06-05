import 'package:dio/dio.dart';
import 'package:morla/core/services/app_api_client.dart';
import 'package:morla/features/dashboard/data/models/dashboard_stats_model.dart';

class DashboardRepository {
  final AppApiClient _apiClient;

  const DashboardRepository({required AppApiClient apiClient})
    : _apiClient = apiClient;

  Future<DashboardStatsModel> getDashboardStats() async {
    try {
      final response = await _apiClient.dio.get('/invoices/stats');

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return DashboardStatsModel.fromJson(data);
    } on DioException catch (error) {
      throw Exception(_extractErrorMessage(error));
    }
  }

  String _extractErrorMessage(DioException error) {
    final data = error.response?.data;

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }

    return error.message ?? 'Request failed';
  }
}
