class OrderModel {
  final String orderNumber;
  final String fullName;
  final String email;
  final String address;
  final String phone;
  final String governorate;
  final String date;
  final double totalPrice;

  const OrderModel({
    required this.orderNumber,
    required this.fullName,
    required this.email,
    required this.address,
    required this.phone,
    required this.governorate,
    required this.date,
    required this.totalPrice,
  });
}