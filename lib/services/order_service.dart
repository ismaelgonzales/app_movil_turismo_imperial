import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class OrderService {
  static const String _url = 'https://shop-api-roan.vercel.app/order';

  static Future<bool> submitOrder({
    required String paymentMethod,
    required String userName,
    required String userPhone,
    required String userAddress,
    required double userLat,
    required double userLng,
    required File userPhoto,
  }) async {
    try {
      String base64Image = base64Encode(await userPhoto.readAsBytes());

      final orderData = {
        "paymentMethod": paymentMethod,
        "userName": userName,
        "userPhone": userPhone,
        "userAddress": userAddress,
        "userLat": userLat,
        "userLng": userLng,
        "userPhoto": base64Image,
      };

      final response = await http.post(
        Uri.parse(_url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(orderData),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
