import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/order_model.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState());

  void addOrder(OrderModel order) {
    final updatedOrders = List<OrderModel>.from(state.orders);
    updatedOrders.insert(0, order);
    emit(OrderState(orders: updatedOrders));
  }
}