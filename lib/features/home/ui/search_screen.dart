import 'dart:async';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/home/data/repo/home_repo.dart';
import 'package:bookstore/core/networking/api_error_handler.dart';
import 'package:bookstore/core/theme/app_colors.dart';
import 'package:bookstore/features/home/ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  final List<Product> products;

  const SearchScreen({super.key, required this.products});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  late List<Product> filteredProducts;
  Timer? debounce;
  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;
    searchController.addListener(_filterProducts);
  }

  void _filterProducts() {
    debounce?.cancel();
    final query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredProducts = widget.products;
        error = null;
        isLoading = false;
      });
      return;
    }
    debounce = Timer(const Duration(milliseconds: 400), () => _search(query));
  }

  Future<void> _search(String query) async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final products = await HomeRepo.searchProducts(query);
      if (!mounted || searchController.text.trim().toLowerCase() != query) {
        return;
      }
      setState(() {
        filteredProducts = products;
        isLoading = false;
      });
    } catch (exception) {
      if (!mounted) return;
      setState(() {
        error = ApiErrorHandler.getMessage(exception);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color borderColor = AppColors.border;
    const Color fillColor = AppColors.searchBackground;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 44.w,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: borderColor),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 18.sp,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Store',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: fillColor,
                  contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(error!, textAlign: TextAlign.center),
                            TextButton(
                              onPressed: () => _search(
                                searchController.text.trim().toLowerCase(),
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : filteredProducts.isEmpty
                    ? Center(
                        child: Text(
                          'No results found',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GridView.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.42,
                        ),
                        itemBuilder: (context, index) {
                          return ProductItem(product: filteredProducts[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
