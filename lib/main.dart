import 'package:flutter/material.dart';
import 'package:idl1_des_app/witgets/boton_detalle_compra.dart';
import 'package:idl1_des_app/witgets/title_with_image.dart';
import 'package:idl1_des_app/witgets/custom_app_bar.dart';
import 'package:idl1_des_app/witgets/product_card.dart';
import 'package:idl1_des_app/models/calidades.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 250, 226, 1) ,
      appBar: const CustomAppBar(), 
      body: const Column( 
        children: <Widget>[
          TitleWithImage(),
          CardExample(calidad: Calidades.economico,),
          CardExample(calidad: Calidades.accesible,),
          CardExample(calidad: Calidades.exclusivo),
          CardExample(calidad : Calidades.cargo)
        ],
      ),
      floatingActionButton: BotonDetalleCompra(onPressed: () {  },),
    );
  }
}
