import 'package:flutter/material.dart';
import 'package:idl1_des_app/carritoCompras/views/witgets/boton_detalle_compra.dart';
import 'package:idl1_des_app/witgets/title_with_image.dart';
import 'package:idl1_des_app/witgets/custom_app_bar.dart';
import 'package:idl1_des_app/witgets/product_card.dart';
import 'package:idl1_des_app/services/service_api.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ApiService().fetchProducts(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 250, 226, 1),
      appBar: const CustomAppBar(),
      body: FutureBuilder<List<Product>>(
        future: _products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            final products = snapshot.data!;
            return SingleChildScrollView( 
              child: Column(
                children: <Widget>[
                  TitleWithImage(),
                  ...products.map((product) => CardExample(product: product)).toList(), 
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: BotonDetalleCompra(
        onPressed: () {
          
        },
      ),
    );
  }
}
