import 'package:bookstore/features/cart/data/models/cart_item_model.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/profile/data/models/order_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('API model parsing', () {
    test('product handles catalog and cart field names', () {
      final product = Product.fromJson({
        'item_product_id': 7,
        'item_product_name': 'Clean Code',
        'item_product_price': '100.00',
        'item_product_price_after_discount': 80,
      });
      expect(product.id, 7);
      expect(product.name, 'Clean Code');
      expect(product.effectivePrice, 80);
    });

    test('cart item uses server total', () {
      final item = CartItemModel.fromJson({
        'item_id': 9,
        'item_product_id': 7,
        'item_product_price': '100.00',
        'item_quantity': 2,
        'item_total': 200,
      });
      expect(item.itemId, 9);
      expect(item.quantity, 2);
      expect(item.total, 200);
    });

    test('order history values are parsed safely', () {
      final order = OrderModel.fromJson({
        'id': 51, 'order_code': '00051', 'order_date': '2026-08-10',
        'status': 'New', 'total': '130.51',
      });
      expect(order.id, 51);
      expect(order.orderNumber, '00051');
      expect(order.totalPrice, 130.51);
    });
  });
}
