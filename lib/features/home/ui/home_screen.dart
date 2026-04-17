// import 'package:bookstore/core/theme/app_colors.dart';
// import 'package:bookstore/features/home/cubit/home_cubit.dart';
// import 'package:bookstore/features/home/ui/widgets/home_app_bar.dart';
// import 'package:bookstore/features/home/ui/widgets/home_slider.dart';
// import 'package:bookstore/features/home/ui/widgets/product_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:skeletonizer/skeletonizer.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         HomeAppBar(),
//         HomeSlider(),
//         SizedBox(height: 10.h,),
//         Text("Best Seller",style: TextStyle(
//           fontSize: 25.sp
//         ),),
//         SizedBox(height: 10.h,),
//         BlocBuilder<HomeCubit, HomeState>(
//           buildWhen: (prev, current) =>
//           current is SliderLoadingState ||
//               current is BestSellerSuccessState ||
//               current is BestSellerErrorState,
//           builder: (context, state) {
//             if (state is SliderLoadingState) {
//               return Expanded(
//                 child: Skeletonizer(
//                   enabled: true,
//                   child: GridView.builder(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 11.w,
//                       mainAxisSpacing: 11.h,
//                       childAspectRatio: .47,
//                     ),
//                     itemCount:6,
//                     itemBuilder: (context, index) {
//                       return ProductItem(
//                         backgroundColor: Colors.grey.shade200,
//                       );
//                     },
//                   ),
//                 ),
//               );
//             } else if (state is BestSellerSuccessState) {
//               return Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 11.w,
//                     mainAxisSpacing: 11.h,
//                     childAspectRatio: .47,
//                   ),
//                   itemCount: state.products?.length ?? 0,
//                   itemBuilder: (context, index) {
//                     return ProductItem(
//                       product: state.products?[index],
//                     );
//                   },
//                 ),
//               );
//             } else if (state is BestSellerErrorState) {
//               return const Text("Error");
//             } else {
//               return const SizedBox.shrink();
//             }
//           },
//         )
//       ],
//     );
//   }
// }


import 'package:bookstore/features/home/cubit/home_cubit.dart';
import 'package:bookstore/features/home/ui/search_screen.dart';
import 'package:bookstore/features/home/ui/widgets/home_app_bar.dart';
import 'package:bookstore/features/home/ui/widgets/home_slider.dart';
import 'package:bookstore/features/home/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/best_seller_response.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getSlider();
    context.read<HomeCubit>().getBestSeller();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Product> products = [];

        if (state is BestSellerSuccessState) {
          products = state.products ?? [];
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                onSearchTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(
                        products: products,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),

              const HomeSlider(),

              SizedBox(height: 16.h),

              Text(
                "Best Seller",
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 12.h),

              Expanded(
                child: state is BestSellerLoadingState
                    ? const Center(child: CircularProgressIndicator())
                    : GridView.builder(
                  itemCount: products.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.42,
                  ),
                  itemBuilder: (context, index) {
                    return ProductItem(
                      product: products[index],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


