import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/cart/ui/cart_screen.dart';
import 'package:bookstore/features/home/cubit/home_cubit.dart';
import 'package:bookstore/features/home/ui/home_screen.dart';
import 'package:bookstore/features/profile/ui/profile_screen.dart';
import 'package:bookstore/features/wishlist/ui/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../gen/assets.gen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex=0;
  List<Widget> screen =[
    BlocProvider(
  create: (context) => HomeCubit()..getSlider()..getBestSeller(),
  child: HomeScreen(),
),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
       currentIndex:activeIndex,
       onTap: (index){
         setState(() {
           activeIndex=index;
         });
       },
          // showUnselecte dLabels: false,
       items: [
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.icons.home1,
        colorFilter:ColorFilter.mode(activeIndex==0? AppColors.mainColor:Colors.black, BlendMode.srcIn) ,

        ),label: ""),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.icons.bookmark,
            colorFilter:ColorFilter.mode(activeIndex==1? AppColors.mainColor:Colors.black, BlendMode.srcIn)
        ),label: ""),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.icons.category,
            colorFilter:ColorFilter.mode(activeIndex==2? AppColors.mainColor:Colors.black, BlendMode.srcIn) ),label: ""),
        BottomNavigationBarItem(icon: SvgPicture.asset(Assets.icons.profile,
            colorFilter:ColorFilter.mode(activeIndex==3? AppColors.mainColor:Colors.black, BlendMode.srcIn) ),label: ""),
      ]),
      body:SafeArea(child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12.w),
        child: screen[activeIndex ],
      )),


    );
  }
}
