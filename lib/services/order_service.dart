
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:idl1_des_app/models/product_model.dart';

class OrderService {
  static const String _url = 'https://shop-api-roan.vercel.app/order';

  static Future<http.Response?> submitOrder({
    required String paymentMethod,
    required String userName,
    required String userPhone,
    required String userAddress,
    required double userLat,
    required double userLng,
    required File userPhoto,
    required List<Product> products,
  }) async {
    try {
      String base64Image = base64Encode(await userPhoto.readAsBytes());


      final productData = products.map((product) => {
        "id": product.id,
        "quantity": product.quantity,
        "amount": product.price.toInt(),
      }).toList();

      final orderData = {
        "products": productData,
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

      print("Código de estado: ${response.statusCode}");
      print("Respuesta del servidor: ${response.body}");

      return response;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
