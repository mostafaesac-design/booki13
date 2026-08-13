import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/features/order/data/repos/order_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit({OrderRepo? repo})
    : _repo = repo ?? OrderRepo(),
      super(const OrderState());
  final OrderRepo _repo;

  Future<void> getGovernorates() async {
    if (state.isLoadingGovernorates) return;
    emit(
      state.copyWith(isLoadingGovernorates: true, clearGovernoratesError: true),
    );
    try {
      emit(
        state.copyWith(
          governorates: await _repo.getGovernorates(),
          isLoadingGovernorates: false,
          clearGovernoratesError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoadingGovernorates: false,
          governoratesError: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<void> getOrders() async {
    if (state.isLoadingOrders) return;
    emit(state.copyWith(isLoadingOrders: true, clearOrdersError: true));
    try {
      emit(
        state.copyWith(
          orders: await _repo.getOrders(),
          isLoadingOrders: false,
          clearOrdersError: true,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoadingOrders: false,
          ordersError: ApiErrorHandler.getMessage(error),
        ),
      );
    }
  }

  Future<int?> placeOrder({
    required int governorateId,
    required String name,
    required String phone,
    required String address,
    required String email,
  }) async {
    if (state.isPlacingOrder) return null;
    emit(state.copyWith(isPlacingOrder: true, clearOrdersError: true));
    try {
      final id = await _repo.placeOrder(
        governorateId: governorateId,
        name: name,
        phone: phone,
        address: address,
        email: email,
      );
      emit(state.copyWith(isPlacingOrder: false, placedOrderId: id));
      return id;
    } catch (error) {
      emit(
        state.copyWith(
          isPlacingOrder: false,
          ordersError: ApiErrorHandler.getMessage(error),
        ),
      );
      return null;
    }
  }
}
