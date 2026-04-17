import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore/features/cart/data/models/cart_item_model.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';

import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart(Product product) {
    final currentItems = List<CartItemModel>.from(state.cartItems);

    final index = currentItems.indexWhere(
          (item) => item.product.id == product.id,
    );

    if (index != -1) {
      currentItems[index] = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + 1,
      );
    } else {
      currentItems.add(
        CartItemModel(
          product: product,
          quantity: 1,
        ),
      );
    }

    emit(CartState(cartItems: currentItems));
  }

  void removeFromCart(int productId) {
    final updatedItems = state.cartItems
        .where((item) => item.product.id != productId)
        .toList();

    emit(CartState(cartItems: updatedItems));
  }

  void increaseQuantity(int productId) {
    final currentItems = List<CartItemModel>.from(state.cartItems);
    final index = currentItems.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index != -1) {
      currentItems[index] = currentItems[index].copyWith(
        quantity: currentItems[index].quantity + 1,
      );

      emit(CartState(cartItems: currentItems));
    }
  }

  void decreaseQuantity(int productId) {
    final currentItems = List<CartItemModel>.from(state.cartItems);
    final index = currentItems.indexWhere(
          (item) => item.product.id == productId,
    );

    if (index != -1) {
      final currentItem = currentItems[index];

      if (currentItem.quantity > 1) {
        currentItems[index] = currentItem.copyWith(
          quantity: currentItem.quantity - 1,
        );
      } else {
        currentItems.removeAt(index);
      }

      emit(CartState(cartItems: currentItems));
    }
  }

  bool isProductInCart(int productId) {
    return state.cartItems.any((item) => item.product.id == productId);
  }
}