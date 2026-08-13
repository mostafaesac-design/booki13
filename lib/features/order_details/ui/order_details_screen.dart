import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_button.dart';
import 'package:bookstore/features/order_details/cubit/order_details_cubit.dart';
import 'package:bookstore/features/order_details/cubit/order_details_state.dart';
import 'package:bookstore/features/order_details/ui/widgets/discount_card.dart';
import 'package:bookstore/features/order_details/ui/widgets/order_address_section.dart';
import 'package:bookstore/features/order_details/ui/widgets/order_details_header.dart';
import 'package:bookstore/features/order_details/ui/widgets/order_product_item.dart';
import 'package:bookstore/features/order_details/ui/widgets/payment_method_tile.dart';
import 'package:bookstore/features/order_details/ui/widgets/payment_summary_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.error!,
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<OrderDetailsCubit>().load();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                24.w,
                20.h,
                24.w,
                28.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderDetailsHeader(
                    orderNumber: state.orderNumber,
                  ),

                  SizedBox(height: 35.h),

                  OrderAddressSection(
                    title: state.addressTitle,
                    details: state.addressDetails,
                    onEditAddress: () {},
                    onAddNote: () {},
                  ),

                  SizedBox(height: 22.h),

                  const Divider(
                    color: AppColors.borderLight,
                  ),

                  SizedBox(height: 14.h),

                  for (
                  var index = 0;
                  index < state.items.length;
                  index++
                  ) ...[
                    OrderProductItem(
                      item: state.items[index],
                      onIncrease: () {
                        context.read<OrderDetailsCubit>().increaseQuantity(
                          state.items[index].product.id ?? 0,
                        );
                      },
                      onDecrease: () {
                        context.read<OrderDetailsCubit>().decreaseQuantity(
                          state.items[index].product.id ?? 0,
                        );
                      },
                    ),
                    if (index != state.items.length - 1)
                      SizedBox(height: 24.h),
                  ],

                  SizedBox(height: 30.h),

                  DiscountCard(
                    count: 1,
                    onTap: () {},
                  ),

                  SizedBox(height: 34.h),

                  PaymentSummarySection(
                    productsPrice: state.productsPrice,
                    oldDeliveryFee: 2,
                    deliveryFee: state.total - state.productsPrice,
                  ),

                  SizedBox(height: 53.h),

                  PaymentMethodTile(
                    total: state.total,
                    onTap: () {},
                  ),

                  SizedBox(height: 17.h),

                  AppButton(
                    text: 'order'.tr(),
                    onTap: () {
                      // سنربط Order API هنا لاحقًا.
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}