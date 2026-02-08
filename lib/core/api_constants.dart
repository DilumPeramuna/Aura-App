class ApiConstants {
  static const String baseUrl = "https://ferlafashion.com";
  static const String apiBaseUrl = "$baseUrl/api";
  static const String mobileBaseUrl = "$apiBaseUrl/mobile";

  // Endpoints
  static const String login = "$apiBaseUrl/login";
  static const String register = "$apiBaseUrl/register";
  static const String createOrder = "$apiBaseUrl/mobile/orders";
  static const String products = "$mobileBaseUrl/products";
  static const String userProfile = "$mobileBaseUrl/user";

  // Image Helper
  static String getImageUrl(String? path) {
    if (path == null) return "https://via.placeholder.com/150";
    if (path.startsWith("http")) return path;
    if (path.startsWith("/")) return "$baseUrl$path";
    return "$baseUrl/$path";
  }
}
