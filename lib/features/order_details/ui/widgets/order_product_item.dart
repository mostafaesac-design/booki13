import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/custom_network_image.dart';
import 'package:bookstore/features/cart/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProductItem extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const OrderProductItem({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: CustomNetworkImage(
            urlImage: item.product.image ?? '',
            width: 58.w,
            height: 58.w,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8.h),
              Text(
                item.product.category ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        _QuantityButton(
          icon: Icons.remove,
          onTap: item.quantity > 1 ? onDecrease : null,
        ),
        SizedBox(width: 15.w),
        SizedBox(
          width: 16.w,
          child: Text(
            '${item.quantity}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(width: 15.w),
        _QuantityButton(icon: Icons.add, onTap: onIncrease),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Icon(
          icon,
          size: 16.sp,
          color: onTap == null ? AppColors.disabled : AppColors.textPrimary,
        ),
      ),
    );
  }
}
