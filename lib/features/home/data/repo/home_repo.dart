import 'package:bookstore/core/networking/api_constants.dart';
import 'package:bookstore/core/networking/dio_service.dart';
import 'package:bookstore/features/home/data/models/best_seller_response.dart';
import 'package:bookstore/features/home/data/models/slider_model.dart';

class HomeRepo {
  static Future<SliderResponse?>? getSlider() async {
    try {
      final response = await DioService.dio.get(ApiConstants.sliders);
      if (response.statusCode == 200) {
        final data = SliderResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  static Future<BestSellerResponse?>? getBestSeller() async {
    try {
      final response = await DioService.dio.get(ApiConstants.bestSeller);
      if (response.statusCode == 200) {
        final data = BestSellerResponse.fromJson(response.data);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Product>> searchProducts(String query) async {
    final response = await DioService.dio.get(
      ApiConstants.productSearch,
      queryParameters: {'name': query},
    );
    final data = response.data is Map ? response.data['data'] : null;
    final raw = data is Map ? data['products'] : null;
    return (raw is List ? raw : const [])
        .whereType<Map>()
        .map((item) => Product.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  static Future<ProductPage> getProducts({int page = 1}) async {
    final response = await DioService.dio.get(
      ApiConstants.products,
      queryParameters: {'page': page},
    );
    final data = response.data is Map ? response.data['data'] : null;
    final raw = data is Map ? data['products'] : null;
    final meta = data is Map && data['meta'] is Map
        ? data['meta'] as Map
        : const {};
    return ProductPage(
      products: (raw is List ? raw : const [])
          .whereType<Map>()
          .map((item) => Product.fromJson(Map<String, dynamic>.from(item)))
          .toList(),
      currentPage: meta['current_page'] is int
          ? meta['current_page'] as int
          : page,
      lastPage: meta['last_page'] is int ? meta['last_page'] as int : page,
    );
  }
}

class ProductPage {
  final List<Product> products;
  final int currentPage;
  final int lastPage;
  const ProductPage({
    required this.products,
    required this.currentPage,
    required this.lastPage,
  });
}
