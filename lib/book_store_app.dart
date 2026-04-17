import 'package:bookstore/core/routes/app_router.dart';
import 'package:bookstore/core/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/profile/cubit/order_cubit.dart';
import 'features/profile/cubit/profile_cubit.dart';
import 'features/wishlist/cubit/wishlist_cubit.dart';

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(),
        ),
        BlocProvider<WishlistCubit>(
          create: (_) => WishlistCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(),
        ),
        BlocProvider<OrderCubit>(
          create: (_) => OrderCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "DM",
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: AppRouter().onGenerateRoute,
          initialRoute: Routes.appStartScreen,
        ),
      ),
    );
  }
}