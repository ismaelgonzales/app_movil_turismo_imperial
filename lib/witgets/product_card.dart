// lib/widgets/product_card.dart

import 'package:flutter/material.dart';

import 'package:idl1_des_app/services/service_api.dart'; // Asegúrate de importar el servicio

class CardExample extends StatelessWidget {
  final Product product; // Cambiamos 'Calidades' a 'Product'
  
  const CardExample({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 230, 72, 85),
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.hardEdge, // Mantiene el InkWell dentro de los bordes
        child: InkWell(
          splashColor: const Color.fromARGB(255, 255, 255, 255).withAlpha(30),
          onTap: () {
            debugPrint('Card tapped: ${product.name}.');
          },
          child: SizedBox(
            width: 400,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // Puedes incluir una imagen de la API si decides agregar un campo 'image' en el futuro
                  // Image.network(product.imageUrl, width: 130), 
                  Text('${product.name}', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('Disponibles${product.stock}', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('S/${product.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
