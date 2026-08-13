import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/features/cart/data/repo/cart_repo.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({CartRepo? repo})
    : _repo = repo ?? CartRepo(),
      super(const CartState());
  final CartRepo _repo;
  final Set<int> _pendingProducts = {};

  Future<void> loadCart() async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      _apply(await _repo.getCart());
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<void> addToCart(Product product) async {
    final id = product.id;
    if (id == null || !_pendingProducts.add(id)) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      _apply(await _repo.add(id));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    } finally {
      _pendingProducts.remove(id);
    }
  }

  Future<void> removeFromCart(int productId) async {
    final item = state.cartItems
        .where((item) => item.product.id == productId)
        .firstOrNull;
    if (item?.itemId == null || !_pendingProducts.add(productId)) return;
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      _apply(await _repo.remove(item!.itemId!));
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    } finally {
      _pendingProducts.remove(productId);
    }
  }

  Future<void> increaseQuantity(int productId) => _changeQuantity(productId, 1);
  Future<void> decreaseQuantity(int productId) =>
      _changeQuantity(productId, -1);

  Future<void> _changeQuantity(int productId, int delta) async {
    final item = state.cartItems
        .where((item) => item.product.id == productId)
        .firstOrNull;
    if (item == null ||
        item.itemId == null ||
        !_pendingProducts.add(productId)) {
      return;
    }
    final quantity = item.quantity + delta;
    try {
      emit(state.copyWith(isLoading: true, clearError: true));
      if (quantity < 1) {
        _apply(await _repo.remove(item.itemId!));
      } else if (quantity <= (item.product.stock ?? quantity)) {
        _apply(
          await _repo.update(cartItemId: item.itemId!, quantity: quantity),
        );
      } else {
        emit(
          state.copyWith(
            isLoading: false,
            error: 'Requested quantity is not available.',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          error: ApiErrorHandler.getMessage(error),
        ),
      );
    } finally {
      _pendingProducts.remove(productId);
    }
  }

  void clearCart() => emit(const CartState());
  bool isProductInCart(int productId) =>
      state.cartItems.any((item) => item.product.id == productId);
  void _apply(CartSnapshot snapshot) => emit(
    CartState(
      cartItems: snapshot.items,
      serverTotal: snapshot.total,
      isLoading: false,
    ),
  );
}
