import 'package:bookstore/features/wishlist/cubit/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState());

  void addToWishlist(Product product) {
    final currentItems = List<Product>.from(state.wishlistItems);

    final exists = currentItems.any((item) => item.id == product.id);

    if (!exists) {
      currentItems.add(product);
      emit(WishlistState(wishlistItems: currentItems));
    }
  }

  void removeFromWishlist(int productId) {
    final updatedItems = state.wishlistItems
        .where((item) => item.id != productId)
        .toList();

    emit(WishlistState(wishlistItems: updatedItems));
  }

  void toggleWishlist(Product product) {
    final exists = state.wishlistItems.any((item) => item.id == product.id);

    if (exists) {
      removeFromWishlist(product.id ?? 0);
    } else {
      addToWishlist(product);
    }
  }

  bool isInWishlist(int productId) {
    return state.wishlistItems.any((item) => item.id == productId);
  }
}