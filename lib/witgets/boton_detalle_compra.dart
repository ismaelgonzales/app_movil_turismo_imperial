// lib/widgets/custom_floating_action_button.dart

import 'package:flutter/material.dart';

class BotonDetalleCompra extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonDetalleCompra({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 230, 72, 85),
      onPressed: () {
            Navigator.push(context, MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text('Siguiente pagina'),
                  ),
                  body: const Center(
                    child: Text(
                      'Estamos en la siguiente pagina',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ));
          },
      child: const Icon(
        Icons.add_shopping_cart,
        color: Color.fromARGB(255, 250, 250, 250),
      ),
    );
  }
}
