class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://codingarabic.online/api/';

  static const String login = 'login';
  static const String sliders = 'sliders';
  static const String register = 'register';
  static const String logout = 'logout';
  static const String forgetPassword = 'forget-password';
  static const String checkForgetPassword = 'check-forget-password';
  static const String resetPassword = 'reset-password';
  static const String bestSeller = 'products-bestseller';
  static const String newArrivals = 'products-new-arrivals';
  static const String products = 'products';
  static const String productSearch = 'products-search';
  static const String productFilter = 'products-filter';
  static const String categories = 'categories';
  static const String settings = 'settings';
  static const String profile = 'profile';
  static const String updateProfile = 'update-profile';
  static const String updatePassword = 'update-password';
  static const String deleteProfile = 'delete-profile';
  static const String wishlist = 'wishlist';
  static const String addToWishlist = 'add-to-wishlist';
  static const String removeFromWishlist = 'remove-from-wishlist';
  static const String cart = 'cart';
  static const String addToCart = 'add-to-cart';
  static const String updateCart = 'update-cart';
  static const String removeFromCart = 'remove-from-cart';
  static const String faqs = 'faqs';
  static const String contactUs = 'contact-us';

  // Governorates
  static const String governorates = 'governorates';

  // Orders
  static const String checkout = 'checkout';
  static const String placeOrder = 'place-order';
  static const String orderHistory = 'order-history';

  static String showSingleOrder(int orderId) {
    return 'order-history/$orderId';
  }

  static String showProduct(int productId) => 'products/$productId';
  static String showCategory(int categoryId) => 'categories/$categoryId';
}
