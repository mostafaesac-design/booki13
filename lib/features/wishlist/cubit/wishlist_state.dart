import 'package:equatable/equatable.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';

class WishlistState extends Equatable {
  final List<Product> wishlistItems;
  final bool isLoading;
  final String? error;

  const WishlistState({
    this.wishlistItems = const [],
    this.isLoading = false,
    this.error,
  });

  WishlistState copyWith({
    List<Product>? wishlistItems,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) => WishlistState(
    wishlistItems: wishlistItems ?? this.wishlistItems,
    isLoading: isLoading ?? this.isLoading,
    error: clearError ? null : error ?? this.error,
  );

  @override
  List<Object?> get props => [wishlistItems, isLoading, error];
}
