import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/features/order/data/repos/order_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  OrderDetailsCubit({
    required int orderId,
    OrderRepo? repo,
  })  : _orderId = orderId,
        _repo = repo ?? OrderRepo(),
        super(const OrderDetailsState()) {
    load();
  }

  final int _orderId;
  final OrderRepo _repo;

  Future<void> load() async {
    emit(const OrderDetailsState(isLoading: true));

    try {
      final response = await _repo.getOrder(_orderId);
      final rawProducts = response['order_products'];

      if (rawProducts is List) {
        for (final rawItem in rawProducts) {
          if (rawItem is! Map) continue;

          final rawProductId = rawItem['product_id'];

          final productId = rawProductId is int
              ? rawProductId
              : int.tryParse('$rawProductId');

          if (productId == null) continue;

          try {
            final product = await _repo.getProduct(productId);
            rawItem['product'] = product;
          } catch (error) {
            debugPrint(
              'Failed to load product $productId: $error',
            );
          }
        }
      }

      emit(OrderDetailsState.fromJson(response));
    } catch (error) {
      debugPrint('ORDER DETAILS ERROR: $error');

      emit(
        OrderDetailsState(
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  void increaseQuantity(int productId) {
    _changeQuantity(productId, 1);
  }

  void decreaseQuantity(int productId) {
    _changeQuantity(productId, -1);
  }

  void _changeQuantity(int productId, int change) {
    final index = state.items.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index == -1) return;

    final currentItem = state.items[index];
    final newQuantity = currentItem.quantity + change;

    if (newQuantity < 1) return;

    final oldProductsPrice = state.items.fold<double>(
      0,
          (sum, item) => sum + item.total,
    );

    final updatedItems = List.of(state.items);

    updatedItems[index] = currentItem.copyWith(
      quantity: newQuantity,
    );

    final newProductsPrice = updatedItems.fold<double>(
      0,
          (sum, item) => sum + item.total,
    );

    final priceDifference = newProductsPrice - oldProductsPrice;

    emit(
      state.copyWith(
        items: updatedItems,
        productsPrice: newProductsPrice,
        total: state.total + priceDifference,
      ),
    );
  }
}