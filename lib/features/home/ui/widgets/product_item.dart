import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/core/widgets/custom_network_image.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../details_screen.dart';

class ProductItem extends StatelessWidget {
  final Product? product;
  final Color? backgroundColor;
  const ProductItem({super.key, this.product, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color:backgroundColor?? AppColors.productBackgroundColor,
        borderRadius: BorderRadius.circular(15.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15.r),
              child: CustomNetworkImage(urlImage:product?.image??"")),
          SizedBox(height: 12.h,),
          Text(product?.name??"",style: TextStyle(
            fontSize: 19.sp
          ),maxLines: 1,
          overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h,),
          Row(
            children: [
              Expanded(
                child: Text(product?.price??"",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold
                ),),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(product: product!),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Container(
                    height: 30.h,
                    width: 60.w,
                    color: AppColors.titleColor,
                    child: Center(
                      child: Text(
                        "Buy",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.borderColor,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
