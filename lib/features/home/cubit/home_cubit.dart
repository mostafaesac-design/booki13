import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/home/data/models/slider_model.dart';
import 'package:bookstore/features/home/data/repo/home_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<SliderModel> sliders = [];
  List<Product> bestSellerProducts = [];
  List<Product> products = [];
  int currentPage = 0;
  int lastPage = 1;
  bool isLoadingMore = false;

  Future<void> loadHomeData() async {
    await Future.wait([getSlider(), getBestSeller(), getProducts()]);
  }

  Future<void> getSlider() async {
    emit(SliderLoadingState());
    final response = await HomeRepo.getSlider();

    if (response != null) {
      sliders = response.data?.sliders ?? [];
      emit(SliderSuccessState(sliders));
    } else {
      emit(SliderErrorState());
    }
  }

  Future<void> getBestSeller() async {
    emit(BestSellerLoadingState());
    final response = await HomeRepo.getBestSeller();

    if (response != null) {
      bestSellerProducts = response.data?.products ?? [];
      emit(BestSellerSuccessState(bestSellerProducts));
    } else {
      emit(BestSellerErrorState());
    }
  }

  Future<void> getProducts({bool loadMore = false}) async {
    if (loadMore && (isLoadingMore || currentPage >= lastPage)) return;
    if (loadMore) {
      isLoadingMore = true;
      emit(ProductsLoadingMoreState());
    } else {
      emit(ProductsLoadingState());
    }
    try {
      final page = await HomeRepo.getProducts(
        page: loadMore ? currentPage + 1 : 1,
      );
      products = loadMore ? [...products, ...page.products] : page.products;
      currentPage = page.currentPage;
      lastPage = page.lastPage;
      isLoadingMore = false;
      emit(ProductsSuccessState());
    } catch (_) {
      isLoadingMore = false;
      emit(ProductsErrorState());
    }
  }
}
