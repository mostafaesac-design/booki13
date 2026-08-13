import 'package:bookstore/features/home/data/models/best_seller_response.dart';

class CartItemModel {
  final int? itemId;
  final Product product;
  final int quantity;
  final double? itemTotal;

  const CartItemModel({
    this.itemId,
    required this.product,
    required this.quantity,
    this.itemTotal,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    itemId: _asInt(json['item_id']),
    product: Product.fromJson(json),
    quantity: _asInt(json['item_quantity']) ?? 1,
    itemTotal: _asDouble(json['item_total']),
  );

  CartItemModel copyWith({
    Product? product,
    int? quantity,
    double? itemTotal,
  }) {
    final updatedProduct = product ?? this.product;
    final updatedQuantity = quantity ?? this.quantity;

    return CartItemModel(
      itemId: itemId,
      product: updatedProduct,
      quantity: updatedQuantity,
      itemTotal:
      itemTotal ?? updatedProduct.effectivePrice * updatedQuantity,
    );
  }

  double get total => itemTotal ?? product.effectivePrice * quantity;

  static int? _asInt(dynamic value) =>
      value is int ? value : int.tryParse('$value');
  static double? _asDouble(dynamic value) =>
      value is num ? value.toDouble() : double.tryParse('$value');
}