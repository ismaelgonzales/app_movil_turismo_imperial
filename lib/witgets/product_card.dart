
import 'package:flutter/material.dart';
import 'package:idl1_des_app/models/calidades.dart';

class CardExample extends StatelessWidget {
  final Calidades calidad ;
  const CardExample({super.key,required this.calidad});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: const Color.fromARGB(255, 230, 72, 85),
        margin: const EdgeInsets.all(20) ,
        clipBehavior: Clip.hardEdge, // Mantiene el InkWell dentro de los bordes
        child: InkWell(
          splashColor: const Color.fromARGB(255, 255, 255, 255).withAlpha(30),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: SizedBox(
            width: 400,
            height: 100,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.network(calidad.imageName,width:130),
                   Text('Lima -> Huancayo\n${calidad.nombre}',textAlign: TextAlign.center,style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white)),
                  Text(calidad.precio,style: TextStyle( fontWeight: FontWeight.bold,color: Colors.white))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}