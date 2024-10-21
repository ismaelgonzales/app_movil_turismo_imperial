import 'package:flutter/material.dart';


class TitleWithImage extends StatelessWidget {
  
  

  const TitleWithImage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: const EdgeInsets.all(15),
      color: const Color.fromARGB(255, 230, 72, 85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            ('Abarrotes'),
            style:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color:Colors.white),
          ),
          Image.network(
            'https://res.cloudinary.com/dyelvotz0/image/upload/v1727587318/LogoImperial_nvve7x.png',
            
            height: 90,
          ),
        ],
      ),
    );
  }
}

