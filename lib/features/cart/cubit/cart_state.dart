import 'package:equatable/equatable.dart';
import 'package:bookstore/features/cart/data/models/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItems;

  const CartState({
    this.cartItems = const [],
  });

  double get totalPrice {
    return cartItems.fold(
      0.0,
          (sum, item) =>
      sum +
          ((double.tryParse(item.product.price ?? '0') ?? 0.0) * item.quantity),
    );
  }

  @override
  List<Object?> get props => [cartItems];
}