import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  final String orderId;
  final String paymentMethod;
  final String userName;
  final String userPhone;
  final String userAddress;
  final double userLat;
  final double userLng;

  const OrderConfirmationPage({
    Key? key,
    required this.orderId,
    required this.paymentMethod,
    required this.userName,
    required this.userPhone,
    required this.userAddress,
    required this.userLat,
    required this.userLng,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirmación de Pedido"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "¡Pedido realizado con éxito!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text("ID del Pedido: $orderId"),
            SizedBox(height: 8),
            Text("Método de Pago: $paymentMethod"),
            SizedBox(height: 8),
            Text("Nombre del Usuario: $userName"),
            SizedBox(height: 8),
            Text("Teléfono del Usuario: $userPhone"),
            SizedBox(height: 8),
            Text("Dirección de Entrega: $userAddress"),
            SizedBox(height: 8),
            Text("Coordenadas de Entrega: ($userLat, $userLng)"),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: Text("Volver al Inicio"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
