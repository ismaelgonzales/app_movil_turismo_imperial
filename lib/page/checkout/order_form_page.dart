import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:idl1_des_app/page/checkout/order_confirmation_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:idl1_des_app/services/order_service.dart';
import 'package:idl1_des_app/Provider/add_to_cart_provider.dart';
import 'package:provider/provider.dart';

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  OrderFormPageState createState() => OrderFormPageState();
}

class OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _paymentMethod;
  Position? _currentPosition;
  String? _address;
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _submitOrder() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_currentPosition == null || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, complete todos los campos')));
      return;
    }

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final products = cartProvider.cart;

    // Llamada a OrderService y manejo de la respuesta completa
    final response = await OrderService.submitOrder(
      paymentMethod: _paymentMethod!,
      userName: _nameController.text,
      userPhone: _phoneController.text,
      userAddress: _address!,
      userLat: _currentPosition!.latitude,
      userLng: _currentPosition!.longitude,
      userPhoto: _image!,
      products: products,
    );

    if (response != null && response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationPage(
            orderId: responseData['id'],
            paymentMethod: responseData['paymentMethod'],
            userName: responseData['userName'],
            userPhone: responseData['userPhone'],
            userAddress: responseData['userAddress'],
            userLat: responseData['userLat'],
            userLng: responseData['userLng'],
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar el pedido')));
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 1024,
        maxWidth: 1024,
        imageQuality: 80);
    if (pickedFile != null) {
      final file = File(pickedFile.path);
      if (await file.length() <= 1024 * 1024) {
        // Max 1MB
        setState(() {
          _image = file;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('La imagen debe pesar menos de 1MB')));
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _address = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario de Compra")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                items: ["cash", "credit-card", "debit-card"].map((String method) {
                  return DropdownMenuItem(value: method, child: Text(method));
                }).toList(),
                onChanged: (value) => setState(() => _paymentMethod = value),
                decoration: const InputDecoration(labelText: 'Método de pago'),
                validator: (value) => value == null ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre completo'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.location_on),
                label: const Text("Obtener mi dirección"),
                onPressed: _getCurrentLocation,
              ),
              if (_address != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Ubicación: $_address"),
                ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Tomar foto de la fachada"),
                onPressed: _pickImage,
              ),
              if (_image != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(_image!, height: 100),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitOrder,
                child: const Text("Comprar"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
