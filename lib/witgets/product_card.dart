import 'package:flutter/material.dart';

import 'package:idl1_des_app/services/service_api.dart'; 


import 'package:idl1_des_app/witgets/product_counter.dart'; // Asegúrate de importar el ProductCounter

class CardExample extends StatelessWidget {
  final Product product;
  
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
                  Text('${product.name}\nStock${product.stock}', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  
                  Text('Precio S/${product.price.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ProductCounter(), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
