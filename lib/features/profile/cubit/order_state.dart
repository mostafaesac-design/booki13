import 'package:equatable/equatable.dart';
import '../data/models/order_model.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;

  const OrderState({
    this.orders = const [],
  });

  @override
  List<Object?> get props => [orders];
}