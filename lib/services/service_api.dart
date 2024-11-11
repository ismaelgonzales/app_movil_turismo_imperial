
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:idl1_des_app/models/product_model.dart';

class ApiService {
  final String baseUrl = 'https://shop-api-roan.vercel.app/product';

  Future<List<ProductApi>> fetchProducts({int page = 1, int pageSize = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl?page=$page&pageSize=$pageSize'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => ProductApi.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
class ProductApi {
  final String id;
  final String slug;
  final String name;
  final String description;
  final double price;
  final int stock;
  int quantity;

  ProductApi({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.quantity = 1,
  });

  factory ProductApi.fromJson(Map<String, dynamic> json) {
    return ProductApi(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      quantity: 1,
    );
  }

 
  Product toProduct() {
    return Product(
      id : this.id,
      title: this.name,
      description: this.description,
   
      price: this.price,
      seller: "Jose Alberto ",  
      colors: [Colors.black, Colors.green,Colors.red],
      category: "Todo", 
      review: "(1234 Reviews)", 
      rate: 4.8, 
      quantity: this.quantity,
    );
  }
}
