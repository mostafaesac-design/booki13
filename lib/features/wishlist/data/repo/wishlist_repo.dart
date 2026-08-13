import 'dart:convert';

import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepo {
  static const String _userEmailKey = 'current_user_email';
  static const String _wishlistPrefix = 'wishlist_';

  Future<List<Product>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();
    final rawWishlist = prefs.getString(await _storageKey(prefs));

    if (rawWishlist == null || rawWishlist.isEmpty) {
      return [];
    }

    try {
      final decoded = jsonDecode(rawWishlist);
      if (decoded is! List) return [];

      return decoded
          .whereType<Map>()
          .map(
            (item) => Product.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<List<Product>> add(Product product) async {
    final id = product.id;
    if (id == null) return getWishlist();

    final items = await getWishlist();
    final updatedItems = [
      product,
      ...items.where((item) => item.id != id),
    ];

    await _save(updatedItems);
    return updatedItems;
  }

  Future<List<Product>> remove(int productId) async {
    final items = await getWishlist();
    final updatedItems = items
        .where((item) => item.id != productId)
        .toList();

    await _save(updatedItems);
    return updatedItems;
  }

  Future<void> _save(List<Product> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items.map(_productToJson).toList());
    await prefs.setString(await _storageKey(prefs), encoded);
  }

  Future<String> _storageKey(SharedPreferences prefs) async {
    final email = prefs.getString(_userEmailKey)?.trim().toLowerCase();
    final accountKey = (email == null || email.isEmpty) ? 'guest' : email;
    return '$_wishlistPrefix$accountKey';
  }

  Map<String, dynamic> _productToJson(Product product) {
    return {
      'id': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'discount': product.discount,
      'price_after_discount': product.priceAfterDiscount,
      'stock': product.stock,
      'image': product.image,
      'category': product.category,
      'best_seller': product.bestSeller,
    };
  }
}
