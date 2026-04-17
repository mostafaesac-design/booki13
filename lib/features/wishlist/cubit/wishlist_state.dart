import 'package:equatable/equatable.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';

class WishlistState extends Equatable {
  final List<Product> wishlistItems;

  const WishlistState({
    this.wishlistItems = const [],
  });

  @override
  List<Object?> get props => [wishlistItems];
}