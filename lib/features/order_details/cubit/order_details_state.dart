import 'package:bookstore/features/cart/data/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

class OrderDetailsState extends Equatable {
  final List<CartItemModel> items;
  final String orderNumber;
  final String addressTitle;
  final String addressDetails;
  final String status;
  final String date;
  final double productsPrice;
  final double total;
  final double discount;
  final bool isLoading;
  final String? error;

  const OrderDetailsState({
    this.items = const [],
    this.orderNumber = '',
    this.addressTitle = '',
    this.addressDetails = '',
    this.status = '',
    this.date = '',
    this.productsPrice = 0,
    this.total = 0,
    this.discount = 0,
    this.isLoading = false,
    this.error,
  });

  OrderDetailsState copyWith({
    List<CartItemModel>? items,
    String? orderNumber,
    String? addressTitle,
    String? addressDetails,
    String? status,
    String? date,
    double? productsPrice,
    double? total,
    double? discount,
    bool? isLoading,
    String? error,
  }) {
    return OrderDetailsState(
      items: items ?? this.items,
      orderNumber: orderNumber ?? this.orderNumber,
      addressTitle: addressTitle ?? this.addressTitle,
      addressDetails: addressDetails ?? this.addressDetails,
      status: status ?? this.status,
      date: date ?? this.date,
      productsPrice: productsPrice ?? this.productsPrice,
      total: total ?? this.total,
      discount: discount ?? this.discount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  factory OrderDetailsState.fromJson(Map<String, dynamic> json) {
    final raw = json['order_products'] is List
        ? json['order_products'] as List
        : const [];
    return OrderDetailsState(
      items: raw
          .whereType<Map>()
          .map(
            (item) => CartItemModel.fromJson({
          ...Map<String, dynamic>.from(item),
          'item_product_id': item['product_id'],
          'item_product_name': item['product_name'],
          'item_product_price': item['product_price'],
          'item_product_price_after_discount':
          item['product_price_after_discount'],
          'item_product_image':
          item['product_image'] ??
              item['image'] ??
              item['product']?['image'],
          'item_quantity': item['order_product_quantity'],
          'item_total': item['product_total'],
        }),
      )
          .toList(),
      orderNumber: (json['order_code'] ?? json['id'] ?? '').toString(),
      addressTitle: json['governorate']?.toString() ?? '',
      addressDetails: json['address']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      date: json['order_date']?.toString() ?? '',
      productsPrice: _double(json['sub_total']),
      total: _double(json['total']),
      discount: _double(json['discount']),
    );
  }

  static double _double(dynamic value) =>
      value is num ? value.toDouble() : double.tryParse('$value') ?? 0;
  @override
  List<Object?> get props => [
    items,
    orderNumber,
    addressTitle,
    addressDetails,
    status,
    date,
    productsPrice,
    total,
    discount,
    isLoading,
    error,
  ];
}