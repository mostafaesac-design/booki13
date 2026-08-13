import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/cart/ui/cart_screen.dart';
import 'package:bookstore/features/cart/cubit/cart_cubit.dart';
import 'package:bookstore/features/home/cubit/home_cubit.dart';
import 'package:bookstore/features/home/ui/home_screen.dart';
import 'package:bookstore/features/profile/ui/profile_screen.dart';
import 'package:bookstore/features/profile/cubit/profile_cubit.dart';
import 'package:bookstore/features/wishlist/ui/wishlist_screen.dart';
import 'package:bookstore/features/wishlist/cubit/wishlist_cubit.dart';
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
  int activeIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();

    screens = [
      BlocProvider(
        create: (context) => HomeCubit()..loadHomeData(),
        child: const HomeScreen(),
      ),
      WishlistScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    context.read<CartCubit>().loadCart();
    context.read<WishlistCubit>().loadWishlist();
    context.read<ProfileCubit>().loadProfile();
  }

  void changeScreen(int index) {
    if (index == activeIndex) return;

    setState(() {
      activeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: activeIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop || activeIndex == 0) return;

        setState(() {
          activeIndex = 0;
        });
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: activeIndex,
          onTap: changeScreen,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.home1,
                colorFilter: ColorFilter.mode(
                  activeIndex == 0 ? AppColors.primary : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.bookmark,
                colorFilter: ColorFilter.mode(
                  activeIndex == 1 ? AppColors.primary : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.category,
                colorFilter: ColorFilter.mode(
                  activeIndex == 2 ? AppColors.primary : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.icons.profile,
                colorFilter: ColorFilter.mode(
                  activeIndex == 3 ? AppColors.primary : Colors.black,
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: IndexedStack(
              index: activeIndex,
              children: screens,
            ),
          ),
        ),
      ),
    );
  }
}
