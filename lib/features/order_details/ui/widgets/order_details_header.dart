import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailsHeader extends StatelessWidget {
  final String orderNumber;

  const OrderDetailsHeader({super.key, required this.orderNumber});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: const AppBackButton(),
          ),
          Text(
            '#$orderNumber',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
