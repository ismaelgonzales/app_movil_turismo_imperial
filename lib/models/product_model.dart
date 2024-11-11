import 'package:flutter/material.dart';
import 'package:idl1_des_app/services/service_api.dart';

class Product {
  final String id;
  final String title;
  final String description;

  final String review;
  final String seller;
  final double price;
  final List<Color> colors;
  final String category;
  final double rate;
  int quantity;

  Product(
      {required this.id,
        required this.title,
      required this.review,
      required this.description,
      
      required this.price,
      required this.colors,
      required this.seller,
      required this.category,
      required this.rate,
      required this.quantity});
}



final ApiService apiService = ApiService();

List<Product> all = []; 


Future<void> fetchAndReplaceProducts() async {
  try {
 
    List<ProductApi> apiProducts = await apiService.fetchProducts();


    all = apiProducts.map((apiProduct) => apiProduct.toProduct()).toList();


   
  } catch (error) {
    print("Error al cargar productos desde la API: $error");
 
  }
}

