import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_page_header.dart';
import 'package:bookstore/features/order_details/cubit/order_details_cubit.dart';
import 'package:bookstore/features/order_details/ui/order_details_screen.dart';
import 'package:bookstore/features/profile/cubit/order_cubit.dart';
import 'package:bookstore/features/profile/cubit/order_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Column(
            children: [
              AppPageHeader(title: 'my_orders'.tr()),
              SizedBox(height: 24.h),
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    if (state.isLoadingOrders && state.orders.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.ordersError != null && state.orders.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              state.ordersError!,
                              textAlign: TextAlign.center,
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.read<OrderCubit>().getOrders(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state.orders.isEmpty) {
                      return Center(child: Text('no_orders'.tr()));
                    }
                    return ListView.separated(
                      itemCount: state.orders.length,
                      separatorBuilder: (_, _) => SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final order = state.orders[index];
                        return InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) =>
                                    OrderDetailsCubit(orderId: order.id),
                                child: const OrderDetailsScreen(),
                              ),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(color: AppColors.borderLight),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${'order_number'.tr()} ${order.orderNumber}',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  order.date,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  order.status,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Text(
                                    '${'total_amount'.tr()}: \$${order.totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
