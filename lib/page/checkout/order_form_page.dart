import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:idl1_des_app/services/order_service.dart';

class OrderFormPage extends StatefulWidget {
   const OrderFormPage({super.key}); // Añadido el parámetro key
  
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

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _address = "${position.latitude}, ${position.longitude}";
    });
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
            SnackBar(content: Text('La imagen debe pesar menos de 1MB')));
      }
    }
  }

  Future<void> _submitOrder() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_currentPosition == null || _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, complete todos los campos')));
      return;
    }

    final success = await OrderService.submitOrder(
      paymentMethod: _paymentMethod!,
      userName: _nameController.text,
      userPhone: _phoneController.text,
      userAddress: _address!,
      userLat: _currentPosition!.latitude,
      userLng: _currentPosition!.longitude,
      userPhoto: _image!,
    );

    if (success) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Pedido enviado con éxito')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error al enviar el pedido')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulario de Compra")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                items: ["Contraentrega"].map((String method) {
                  return DropdownMenuItem(value: method, child: Text(method));
                }).toList(),
                onChanged: (value) => setState(() => _paymentMethod = value),
                decoration: InputDecoration(labelText: 'Método de pago'),
                validator: (value) => value == null ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre completo'),
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? 'Campo requerido' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.location_on),
                label: Text("Obtener mi dirección"),
                onPressed: _getCurrentLocation,
              ),
              if (_address != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text("Ubicación: $_address"),
                ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text("Tomar foto de la fachada"),
                onPressed: _pickImage,
              ),
              if (_image != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.file(_image!, height: 100),
                ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitOrder,
                child: Text("Comprar"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
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
