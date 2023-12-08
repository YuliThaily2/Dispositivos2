import 'package:ejemplo_3/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop(); // Acción de retroceso
              },
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'images/fondo.jpg'), // Reemplaza con la ruta correcta de tu imagen de fondo
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    'images/avatar.jpg'), // Reemplaza con la ruta correcta de tu imagen de avatar
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  'Thaily Gonzalez',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Correo Electrónico: Thaily123@example.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text('Cerrar Sesión'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
