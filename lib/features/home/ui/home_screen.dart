import 'package:bookstore/core/routes/routes.dart';
import 'package:bookstore/features/home/cubit/home_cubit.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/home/ui/search_screen.dart';
import 'package:bookstore/features/home/ui/widgets/home_app_bar.dart';
import 'package:bookstore/features/home/ui/widgets/home_slider.dart';
import 'package:bookstore/features/home/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (_, current) =>
          current is ProductsLoadingState ||
          current is ProductsLoadingMoreState ||
          current is ProductsSuccessState ||
          current is ProductsErrorState,
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final products = cubit.products;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                onNotificationsTap: () =>
                    Navigator.pushNamed(context, Routes.notificationsScreen),
                onSearchTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SearchScreen(products: products),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              const HomeSlider(),
              SizedBox(height: 16.h),
              Text(
                'All Books',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12.h),
              Expanded(child: _catalog(state, cubit, products)),
            ],
          ),
        );
      },
    );
  }

  Widget _catalog(HomeState state, HomeCubit cubit, List<Product> products) {
    if (state is ProductsLoadingState && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is ProductsErrorState && products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Failed to load products'),
            TextButton(
              onPressed: () => cubit.getProducts(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (products.isEmpty) {
      return const Center(child: Text('No books available.'));
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          cubit.getProducts(loadMore: true);
        }
        return false;
      },
      child: GridView.builder(
        itemCount: products.length + (cubit.isLoadingMore ? 1 : 0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.42,
        ),
        itemBuilder: (_, index) => index >= products.length
            ? const Center(child: CircularProgressIndicator())
            : ProductItem(product: products[index]),
      ),
    );
  }
}
