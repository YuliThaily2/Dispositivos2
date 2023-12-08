import 'dart:convert';
import 'dart:io';
import 'package:ejemplo_3/screens/cart_screen.dart';
import 'package:ejemplo_3/screens/product_screen.dart';
import 'package:ejemplo_3/screens/profile_screen.dart';
import 'package:ejemplo_3/screens/wishlist_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/product_card.dart';
import 'product_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  String? _selectedFilePath;
  String? _jsonKey;
  dynamic _jsonData;

  List catList = ['All', "Best Selling", "Jackets", "Shirt", "Pants", "bags"];
  List imgList = ["vestido", "VestidoV", "BlusaR", "BlusaA"];

  //Metodo para file pciker
  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      String fileContent = await file.readAsString();

      setState(() {
        _selectedFilePath = file.path;
        _jsonKey = 'texto1';
        _jsonData = jsonDecode(fileContent);
      });
    }
    if (_selectedFilePath != null) {
      _showAlertDialog(context);
    }
  }

  /// Método para cargar un nuevo producto
  void loadNewProduct(BuildContext context) async {
    final String response = await rootBundle.loadString('new_product.json');
    final data = json.decode(response);
    if (data is List) {
      final Map<String, dynamic> newProduct = data.first;
      showProductDialog(context, newProduct['name']);
    }
  }

  // Método para generar una ventana emergente con el nuevo producto
  void showProductDialog(BuildContext context, String productName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nuevo Producto Añadido'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Producto: $productName'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Metodo para la busqueda
  void handleSearch(BuildContext context, String query) {
    // Buscar en imgList para una coincidencia
    String? foundProduct = imgList.firstWhere(
        (product) => product.toLowerCase() == query.toLowerCase(),
        orElse: () => null);

    // Si se encuentra una coincidencia, navegar a la página de detalles del producto
    if (foundProduct != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ProductScreen(foundProduct),
        ),
      );
    } else {
      // Mostrar algún mensaje de que no se encontró el producto
      // Puedes usar un Snackbar, por ejemplo, para mostrar el mensaje
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Product not found"),
      ));
    }
  }

  //metodo para mostrar un alerta del json
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Archivo seleccionado'),
          content: Text(_jsonData[_jsonKey]
              .toString()), // Asegúrate de que esta línea no cause errores
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedFilePath = null;
                  _jsonKey = null;
                  _jsonData = null;
                });
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8Fa),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          controller: searchController,
                          decoration: InputDecoration(
                            label: Text("Find Your Product"),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                                size: 30, color: Colors.grey),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () =>
                                  handleSearch(context, searchController.text),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25, top: 20),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "images/cover.jpg",
                      width: MediaQuery.of(context).size.width / 1.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        for (int i = 0; i < catList.length; i++)
                          Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            decoration: BoxDecoration(
                                color: catList[i] == "All"
                                    ? Color(0xFFFD725A)
                                    : Color(0xFFF7F8FA),
                                borderRadius: BorderRadius.circular(18)),
                            child: Text(
                              catList[i],
                              style: TextStyle(
                                fontSize: 16,
                                color: catList[i] == "All"
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (MediaQuery.of(context).size.width - 30 - 15) /
                            (2 * 290),
                    mainAxisSpacing: 45,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: imgList.length,
                  itemBuilder: (_, i) {
                    if (i % 2 == 0) {
                      return ProductCard(imgList[i]);
                    }
                    return OverflowBox(
                      maxHeight: 290.0 + 70.0,
                      child: Container(
                        margin: EdgeInsets.only(top: 70),
                        child: ProductCard(imgList[i]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 30,
        selectedItemColor: Color(0xFFFD725A),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // 'Home' es el ítem actual, por lo que no es necesario hacer nada
              break;
            case 1:
              // Navegar a la página del carrito
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartScreen()));
              break;
            case 2:
              // Navegar a la lista de deseos
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WishlistScreen()));
              break;
            case 3:
              // Navegar a la página de perfil de usuario
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFD7254),
        child: Icon(Icons.add_circle_sharp),
        onPressed: _pickFile, // Pasa el contexto aquí
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
