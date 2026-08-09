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

  // Governorates
  static const String governorates = 'governorates';

  // Orders
  static const String checkout = 'checkout';
  static const String placeOrder = 'place-order';
  static const String orderHistory = 'order-history';

  static String showSingleOrder(int orderId) {
    return 'order-history/$orderId';
  }
}