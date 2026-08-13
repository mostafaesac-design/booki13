class OrderModel {
  final int id;
  final String orderNumber;
  final String date;
  final String status;
  final double totalPrice;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: _asInt(json['id']) ?? 0,
    orderNumber: (json['order_code'] ?? json['id'] ?? '').toString(),
    date: json['order_date']?.toString() ?? '',
    status: json['status']?.toString() ?? '',
    totalPrice: _asDouble(json['total']) ?? 0,
  );

  static int? _asInt(dynamic value) =>
      value is int ? value : int.tryParse('$value');
  static double? _asDouble(dynamic value) =>
      value is num ? value.toDouble() : double.tryParse('$value');
}
