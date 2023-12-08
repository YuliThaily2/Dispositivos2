import "package:flutter/material.dart";

import "../screens/product_screen.dart";

class ProductCard extends StatelessWidget {
  String img;
  ProductCard(this.img);

  @override
  Widget build(BuildContext context) {
    return Material( // Envolver con un widget Material
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color.fromARGB(255, 224, 224, 244),
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductScreen(img)));
                    },
                    child: Image.asset(
                      "images/${img}.jpg",
                      fit: BoxFit.cover,
                      height: 210,
                      width: 300,
                    ),
                  ),
                  // Resto del código...
                ],
              ),
            ),
          ),
          // Resto del código...
        ],
      ),
    );
  }
}
