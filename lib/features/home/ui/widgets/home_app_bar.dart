import 'package:bookstore/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onSearchTap;

  const HomeAppBar({
    super.key,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.images.splash.image(
          width: 100.w,
        ),
        GestureDetector(
          onTap: onSearchTap,
          child: Icon(
            Icons.search,
            size: 24.sp,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}