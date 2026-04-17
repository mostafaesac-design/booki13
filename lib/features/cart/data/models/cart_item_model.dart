import 'package:bookstore/features/home/data/models/best_seller_response.dart';

class CartItemModel {
  final Product product;
  final int quantity;

  const CartItemModel({
    required this.product,
    required this.quantity,
  });

  CartItemModel copyWith({
    Product? product,
    int? quantity,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}