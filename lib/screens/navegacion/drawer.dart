import 'package:flutter/material.dart';
import 'package:nethub/main.dart';
import 'package:nethub/screens/navegacion/listaCiudad.dart';

import 'package:nethub/screens/gastronomiaScreen.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Item para la pantalla principal (bienvenida)
          ListTile(
            title: Text("Bienvenida"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => WelcomeScreen())),
          ),
          // Item para la pantalla de login
          ListTile(
            title: Text("Gastronomía"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => GastronomyScreen())),
          ),
          ListTile(
            title: Text("Ciudades"),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => ListaCiudadesScreen())),
          ),
        ],
      ),
    );
  }
}
