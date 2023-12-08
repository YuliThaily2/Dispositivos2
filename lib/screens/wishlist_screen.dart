import 'package:flutter/material.dart';

import '../widgets/wishlist_item.dart'; // Asegúrate de que este widget exista y esté apropiadamente configurado para mostrar productos en la lista de deseos

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                      ),
                    ),
                    Text(
                      "Wishlist", // Cambiado de "Cart" a "Wishlist"
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // Aquí puedes agregar una acción, como por ejemplo, la edición de la lista de deseos
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: [
                    WishlistItemSamples(), // Cambiado de CartItemSamples a WishlistItemSamples
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
