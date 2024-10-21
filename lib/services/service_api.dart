// lib/services_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://shop-api-roan.vercel.app/product';

  Future<List<Product>> fetchProducts({int page = 1, int pageSize = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&pageSize=$pageSize'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final String id;
  final String slug;
  final String name;
  final String description;
  final double price;
  final int stock;

  Product({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
    );
  }
}
