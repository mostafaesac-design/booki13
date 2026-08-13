import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/wishlist/data/repo/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({WishlistRepo? repo})
      : _repo = repo ?? WishlistRepo(),
        super(const WishlistState());

  final WishlistRepo _repo;
  final Set<int> _pending = {};

  Future<void> loadWishlist() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final items = await _repo.getWishlist();
      emit(WishlistState(wishlistItems: items));
    } catch (_) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Unable to load wishlist.',
        ),
      );
    }
  }

  Future<void> addToWishlist(Product product) async {
    final id = product.id;
    if (id == null || !_pending.add(id)) return;

    final previousItems = List<Product>.from(state.wishlistItems);
    final updatedItems = [
      product,
      ...previousItems.where((item) => item.id != id),
    ];

    emit(
      state.copyWith(
        wishlistItems: updatedItems,
        clearError: true,
      ),
    );

    try {
      final savedItems = await _repo.add(product);
      emit(WishlistState(wishlistItems: savedItems));
    } catch (_) {
      emit(
        state.copyWith(
          wishlistItems: previousItems,
          error: 'Unable to save wishlist.',
        ),
      );
    } finally {
      _pending.remove(id);
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    if (productId <= 0 || !_pending.add(productId)) return;

    final previousItems = List<Product>.from(state.wishlistItems);
    final updatedItems = previousItems
        .where((item) => item.id != productId)
        .toList();

    emit(
      state.copyWith(
        wishlistItems: updatedItems,
        clearError: true,
      ),
    );

    try {
      final savedItems = await _repo.remove(productId);
      emit(WishlistState(wishlistItems: savedItems));
    } catch (_) {
      emit(
        state.copyWith(
          wishlistItems: previousItems,
          error: 'Unable to update wishlist.',
        ),
      );
    } finally {
      _pending.remove(productId);
    }
  }

  Future<void> toggleWishlist(Product product) async {
    final id = product.id;
    if (id == null) return;

    if (isInWishlist(id)) {
      await removeFromWishlist(id);
    } else {
      await addToWishlist(product);
    }
  }

  bool isInWishlist(int productId) {
    return state.wishlistItems.any((item) => item.id == productId);
  }
}
