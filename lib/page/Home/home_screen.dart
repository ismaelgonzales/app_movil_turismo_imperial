import 'package:idl1_des_app/models/product_model.dart';
import 'package:idl1_des_app/page/Home/Widget/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:idl1_des_app/services/service_api.dart';

import '../../models/category.dart';
import 'Widget/home_app_bar.dart';
import 'Widget/image_slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  int selectedIndex = 0;
  
  // Lista para almacenar los productos (se actualizará después de obtenerlos de la API)
  List<List<Product>> selectcategories = [all];

  @override
  void initState() {
    super.initState();
    // Llamamos al método para obtener productos de la API
    fetchAndReplaceProducts();
  }

  Future<void> fetchAndReplaceProducts() async {
    try {
      // Llamamos a la API y obtenemos los productos
      List<ProductApi> apiProducts = await ApiService().fetchProducts();

      // Convertimos los productos de la API a productos locales
      List<Product> updatedProducts = apiProducts.map((apiProduct) => apiProduct.toProduct()).toList();

      // Actualizamos el estado con los nuevos productos
      setState(() {
        selectcategories[0] = updatedProducts;
      });
    } catch (error) {
      print("Error al cargar productos desde la API: $error");
      // Si hay un error, puedes dejar los productos mock o manejarlo de otra manera
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const CustomAppBar(),
              const SizedBox(height: 20),
              ImageSlider(
                currentSlide: currentSlider,
                onChange: (value) {
                  setState(() {
                    currentSlider = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              // Cuerpo para mostrar productos
              if (selectedIndex == 0)
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Especial para ti ",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      "Todo",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: selectcategories[selectedIndex].length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: selectcategories[selectedIndex][index],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox categoryItems() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedIndex == index
                    ? Colors.blue[200]
                    : Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(categoriesList[index].image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoriesList[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
