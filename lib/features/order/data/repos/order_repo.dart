import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:bookstore/features/order/data/models/governorate_model.dart';
import 'package:bookstore/features/profile/data/models/order_model.dart';

class OrderRepo {
  Future<List<GovernorateModel>> getGovernorates() async {
    final response = await DioService.dio.get(ApiConstants.governorates);
    final raw = response.data is Map ? response.data['data'] : null;
    return (raw is List ? raw : const [])
        .whereType<Map>()
        .map(
          (item) => GovernorateModel.fromJson(Map<String, dynamic>.from(item)),
        )
        .toList();
  }

  Future<List<OrderModel>> getOrders() async {
    final response = await DioService.dio.get(ApiConstants.orderHistory);
    final data = response.data is Map ? response.data['data'] : null;
    final raw = data is Map ? data['orders'] : null;
    return (raw is List ? raw : const [])
        .whereType<Map>()
        .map((item) => OrderModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<Map<String, dynamic>> getOrder(int id) async {
    final response = await DioService.dio.get(ApiConstants.showSingleOrder(id));
    final data = response.data is Map ? response.data['data'] : null;
    return data is Map ? Map<String, dynamic>.from(data) : const {};
  }

  Future<int> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    final response = await DioService.dio.post(
      ApiConstants.placeOrder,
      data: {
        'governorate_id': governorateId,
        'name': name,
        'phone': phone,
        'address': address,
        'email': email,
      },
    );

    final data = response.data is Map ? response.data['data'] : null;
    final id = data is Map ? data['id'] : null;

    return id is int ? id : int.tryParse('$id') ?? 0;
  }

  Future<Map<String, dynamic>> getProduct(int productId) async {
    final response = await DioService.dio.get(
      ApiConstants.showProduct(productId),
    );

    final data = response.data is Map
        ? response.data['data']
        : null;

    return data is Map
        ? Map<String, dynamic>.from(data)
        : <String, dynamic>{};
  }
}
