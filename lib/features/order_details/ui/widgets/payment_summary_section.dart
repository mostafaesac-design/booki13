import 'package:bookstore/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSummarySection extends StatelessWidget {
  final double productsPrice;
  final double oldDeliveryFee;
  final double deliveryFee;

  const PaymentSummarySection({
    super.key,
    required this.productsPrice,
    required this.oldDeliveryFee,
    required this.deliveryFee,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payment_summary'.tr(),
          style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 23.h),
        _SummaryRow(
          label: 'price'.tr(),
          trailing: '\$ ${productsPrice.toStringAsFixed(2)}',
        ),
        SizedBox(height: 14.h),
        Row(
          children: [
            Text('delivery_fee'.tr(), style: TextStyle(fontSize: 15.sp)),
            const Spacer(),
            Text(
              '\$ ${oldDeliveryFee.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            SizedBox(width: 9.w),
            Text(
              '\$ ${deliveryFee.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String trailing;

  const _SummaryRow({required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 15.sp)),
        const Spacer(),
        Text(
          trailing,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
