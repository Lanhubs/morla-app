import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:billkit/core/services/app_api_client.dart';
import 'package:billkit/features/new_invoice/data/models/new_invoice_model.dart';

class NewInvoiceRepository {
  final AppApiClient _apiClient;

  NewInvoiceRepository({AppApiClient? apiClient})
    : _apiClient = apiClient ?? Get.find<AppApiClient>();

  Future<NewInvoiceModel> createInvoice(NewInvoiceModel invoice) async {
    try {
      final response = await _apiClient.dio.post(
        '/invoices',
        data: invoice.toJson(),
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return NewInvoiceModel.fromJson(data);
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

  Future<NewInvoiceModel?> getInvoice(String id) async {
    try {
      final response = await _apiClient.dio.get('/invoices/$id');
      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      return NewInvoiceModel.fromJson(data);
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

  Future<List<NewInvoiceModel>> listInvoices({
    String? status,
    String? clientId,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (status != null) queryParameters['status'] = status;
      if (clientId != null) queryParameters['clientId'] = clientId;

      final response = await _apiClient.dio.get(
        '/invoices',
        queryParameters: queryParameters,
      );

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Invalid server response');
      }

      final items = data['items'];
      if (items is! List) {
        throw Exception('Invalid server response');
      }

      return items
          .map((e) => NewInvoiceModel.fromJson(e as Map<String, dynamic>))
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
}
