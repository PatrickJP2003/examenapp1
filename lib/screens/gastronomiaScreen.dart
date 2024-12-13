import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nethub/screens/navegacion/drawer.dart';

class GastronomyScreen extends StatelessWidget {
  final TextEditingController _dishController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _idController = TextEditingController(); // Controlador para el ID
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800], // Fondo oscuro y moderno
      appBar: AppBar(
        title: Text(
          "Gastronomía de Ecuador",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.teal[600],
        elevation: 4,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              // Acciones del botón de configuración
            },
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text(
                "Platillos Típicos de Ecuador",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _idController,
                label: "ID del Platillo",
                icon: Icons.code,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _dishController,
                label: "Platillo Típico",
                icon: Icons.fastfood,
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _cityController,
                label: "Ciudad",
                icon: Icons.location_city,
              ),
              SizedBox(height: 40),
              _buildSubmitButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.teal),
          prefixIcon: Icon(icon, color: Colors.teal),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        style: TextStyle(color: Colors.teal[800]),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String id = _idController.text;
        String dish = _dishController.text;
        String city = _cityController.text;
        if (id.isNotEmpty && dish.isNotEmpty && city.isNotEmpty) {
          _saveDishToDatabase(id, dish, city);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Platillo agregado exitosamente!")),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Por favor llena todos los campos")),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.orange[600],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "Agregar Platillo",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _saveDishToDatabase(String id, String dish, String city) {
    final dishRef = _database.ref("gastronomy/$id");
    dishRef.set({
      "dish": dish,
      "city": city,
    });
  }
}
