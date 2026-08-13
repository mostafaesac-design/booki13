import 'package:equatable/equatable.dart';
import 'package:bookstore/features/cart/data/models/cart_item_model.dart';

class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final bool isLoading;
  final String? error;
  final double? serverTotal;

  const CartState({
    this.cartItems = const [],
    this.isLoading = false,
    this.error,
    this.serverTotal,
  });

  double get totalPrice {
    return cartItems.fold(
      0.0,
          (sum, item) {
        final price = double.tryParse(item.product.price ?? '0') ?? 0.0;
        return sum + (price * item.quantity);
      },
    );
  }

  CartState copyWith({
    List<CartItemModel>? cartItems,
    bool? isLoading,
    String? error,
    bool clearError = false,
    double? serverTotal,
  }) => CartState(
    cartItems: cartItems ?? this.cartItems,
    isLoading: isLoading ?? this.isLoading,
    error: clearError ? null : error ?? this.error,
    serverTotal: serverTotal ?? this.serverTotal,
  );

  @override
  List<Object?> get props => [cartItems, isLoading, error, serverTotal];
}
