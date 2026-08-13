import 'package:equatable/equatable.dart';
import 'package:bookstore/features/order/data/models/governorate_model.dart';
import '../data/models/order_model.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;
  final List<GovernorateModel> governorates;
  final bool isLoadingGovernorates;
  final String? governoratesError;
  final bool isLoadingOrders;
  final bool isPlacingOrder;
  final String? ordersError;
  final int? placedOrderId;

  const OrderState({
    this.orders = const [],
    this.governorates = const [],
    this.isLoadingGovernorates = false,
    this.governoratesError,
    this.isLoadingOrders = false,
    this.isPlacingOrder = false,
    this.ordersError,
    this.placedOrderId,
  });

  OrderState copyWith({
    List<OrderModel>? orders,
    List<GovernorateModel>? governorates,
    bool? isLoadingGovernorates,
    String? governoratesError,
    bool clearGovernoratesError = false,
    bool? isLoadingOrders,
    bool? isPlacingOrder,
    String? ordersError,
    bool clearOrdersError = false,
    int? placedOrderId,
  }) {
    return OrderState(
      orders: orders ?? this.orders,
      governorates: governorates ?? this.governorates,
      isLoadingGovernorates:
          isLoadingGovernorates ?? this.isLoadingGovernorates,
      governoratesError: clearGovernoratesError
          ? null
          : governoratesError ?? this.governoratesError,
      isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      ordersError: clearOrdersError ? null : ordersError ?? this.ordersError,
      placedOrderId: placedOrderId ?? this.placedOrderId,
    );
  }

  @override
  List<Object?> get props => [
    orders,
    governorates,
    isLoadingGovernorates,
    governoratesError,
    isLoadingOrders,
    isPlacingOrder,
    ordersError,
    placedOrderId,
  ];
}
