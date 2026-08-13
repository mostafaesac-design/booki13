import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:bookstore/features/cart/data/models/cart_item_model.dart';

class CartSnapshot {
  final List<CartItemModel> items;
  final double total;

  const CartSnapshot({required this.items, required this.total});

  factory CartSnapshot.fromResponse(dynamic responseData) {
    final envelope = responseData is Map ? responseData : const {};
    final data = envelope['data'] is Map ? envelope['data'] as Map : const {};
    final rawItems = data['cart_items'] is List
        ? data['cart_items'] as List
        : const [];
    return CartSnapshot(
      items: rawItems
          .whereType<Map>()
          .map(
            (item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList(),
      total: _asDouble(data['total']) ?? 0,
    );
  }

  static double? _asDouble(dynamic value) =>
      value is num ? value.toDouble() : double.tryParse('$value');
}

class CartRepo {
  Future<CartSnapshot> getCart() async => CartSnapshot.fromResponse(
    (await DioService.dio.get(ApiConstants.cart)).data,
  );

  Future<CartSnapshot> add(int productId) async => CartSnapshot.fromResponse(
    (await DioService.dio.post(
      ApiConstants.addToCart,
      data: {'product_id': productId},
    )).data,
  );

  Future<CartSnapshot> update({
    required int cartItemId,
    required int quantity,
  }) async => CartSnapshot.fromResponse(
    (await DioService.dio.post(
      ApiConstants.updateCart,
      data: {'cart_item_id': cartItemId, 'quantity': quantity},
    )).data,
  );

  Future<CartSnapshot> remove(int cartItemId) async =>
      CartSnapshot.fromResponse(
        (await DioService.dio.post(
          ApiConstants.removeFromCart,
          data: {'cart_item_id': cartItemId},
        )).data,
      );
}
