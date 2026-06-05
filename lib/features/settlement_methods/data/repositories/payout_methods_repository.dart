import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:morla/core/services/app_api_client.dart';
import 'package:morla/features/settlement_methods/data/models/payout_method_model.dart';

class PayoutMethodsRepository {
  final AppApiClient _apiClient;

  PayoutMethodsRepository({AppApiClient? apiClient})
    : _apiClient = apiClient ?? Get.find<AppApiClient>();

  Future<List<PayoutMethodModel>> getPayoutMethods() async {
    try {
      final response = await _apiClient.dio.get('/payout-methods');
      final data = response.data;
      
      if (data is! Map<String, dynamic> || data['items'] is! List) {
        throw Exception('Invalid server response');
      }

      final items = data['items'] as List;
      return items
          .map((e) => PayoutMethodModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          throw Exception(backendMessage.toString());
        }
      }
      rethrow;
    }
  }

  Future<PayoutMethodModel> createPayoutMethod(PayoutMethodModel model) async {
    try {
      final response = await _apiClient.dio.post(
        '/payout-methods',
        data: model.toJson(),
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return PayoutMethodModel.fromJson(data);
    } catch (e) {
      if (e is DioException) {
        final backendMessage = e.response?.data?['message'];
        if (backendMessage != null) {
          throw Exception(backendMessage.toString());
        }
      }
      rethrow;
    }
  }
}
