import 'dart:convert';
import 'package:aura1/core/api_constants.dart';
import 'package:aura1/models/product_model.dart';
import 'package:aura1/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // --- Auth ---

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'Success') {
        final token = data['data']['access_token'];
        await saveToken(token);
        return {'success': true, 'data': data['data']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Login failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password, String passwordConfirmation) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Assuming register also returns token or logic to login after
        return {'success': true, 'message': data['message']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Registration failed', 'errors': data['errors']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  // --- Orders ---

  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final token = await getToken();
      final response = await http.post(
        Uri.parse(ApiConstants.createOrder),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(orderData),
      ).timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'message': data['message'] ?? 'Order created successfully'};
      } else {
        // Backend (BaseApiResponse) returns errors in 'data' field
        return {
          'success': false, 
          'message': data['message'] ?? 'Failed to create order', 
          'errors': data['data'] ?? data['errors']
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  // --- Products ---

  Future<List<Product>> getProducts({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiConstants.products}?page=$page"),
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['status'] == 'Success') {
          final List<dynamic> productList = body['data']['data'];
          return productList.map((json) => Product.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }
}
