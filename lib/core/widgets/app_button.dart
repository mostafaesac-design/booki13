import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';


class AppButton extends StatelessWidget {

  final Color? backgroundColor;
  final String text;
  final VoidCallback? onTap;

  const AppButton({super.key,this.backgroundColor, required this.text,  this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 19.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:backgroundColor==null?null:Border.all(
            color: Colors.black
          ) ,
          borderRadius: BorderRadius.circular(25.r),
          color: backgroundColor??AppColors.mainColor
        ),
        child: Text(text,style: TextStyle(
          fontSize: 15.sp,
          color:backgroundColor==null?Colors.white:Colors.black,

        ),),
      ),
    );
  }
}
