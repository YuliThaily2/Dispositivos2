import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WishlistItemSamples extends StatelessWidget {
  final List<String> imgList = ["vestido", "VestidoV", "BlusaR"]; // Lista de imágenes para demostración

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            height: 110,
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 224, 224, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset("images/${imgList[i]}.jpg"), // Imagen del producto
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        imgList[i],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        "Categoría", // Cambiado de "Best Selling" a "Categoría"
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        "\$300.54", // Precio del producto
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFD725A),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.delete, // Ícono para eliminar de la lista de deseos
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    // Aquí puedes implementar la lógica para eliminar el producto de la lista de deseos
                  },
                ),
              ],
            ),
          )
      ],
    );
  }
}
