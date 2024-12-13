import 'dart:convert'; 
import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http;
import 'package:nethub/screens/navegacion/drawer.dart'; 
 
// Función para obtener los datos de las ciudades desde la API 
Future<List> obtenerCiudades(String url) async { 
  final response = await http.get(Uri.parse(url)); 
 
  if (response.statusCode == 200) { 
    final data = json.decode(response.body); 
    return data['ciudades']; // Accede a la lista bajo la clave 'ciudades' 
  } else { 
    throw Exception("No se pudo conectar"); 
  } 
} 
 
class ListaCiudadesScreen extends StatelessWidget { 
  const ListaCiudadesScreen({super.key}); 
 
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      drawer: MyDrawer(), 
      appBar: AppBar( 
        title: Text("Ciudades"), 
      ), 
      body: listViewCiudades("https://jritsqmet.github.io/web-api/ciudades2.json"), 
    ); 
  } 
 
  // Función que maneja la visualización de las ciudades 
  Widget listViewCiudades(String url) { 
    return FutureBuilder( 
      future: obtenerCiudades(url), // Llama a la función que obtiene los datos 
      builder: (context, snapshot) { 
        if (snapshot.hasData) { 
          final data = snapshot.data!; 
 
          return ListView.builder( 
            itemCount: data.length, 
            itemBuilder: (context, index) { 
              final ciudad = data[index]; 
              return Card( 
                child: ListTile( 
                  title: Text(ciudad['nombre']), // Nombre de la ciudad 
                  subtitle: Text(ciudad['provincia']), // Provincia 
                  leading: Image.network(ciudad['informacion']['imagen'], width: 50, height: 50), // Imagen de la ciudad 
                  onTap: () { 
                    // Al tocar un elemento, mostrar más información en un AlertDialog 
                    _showCityDetails(ciudad, context); 
                  }, 
                ), 
              ); 
            }, 
          ); 
        } else if (snapshot.hasError) { 
          return Center(child: Text('Error: ${snapshot.error}')); 
        } else { 
          return Center(child: CircularProgressIndicator()); 
        } 
      }, 
    ); 
  } 
 
  // Función que muestra un cuadro de diálogo con más detalles de la ciudad 
  void _showCityDetails(Map ciudad, BuildContext context) { 
    showDialog( 
      context: context, 
      builder: (BuildContext context) { 
        return AlertDialog( 
          title: Text(ciudad['nombre']), 
          content: Column( 
            crossAxisAlignment: CrossAxisAlignment.start, 
            mainAxisSize: MainAxisSize.min, 
            children: [ 
              Image.network(ciudad['informacion']['imagen']), // Imagen de la ciudad 
              SizedBox(height: 10), 
              Text("Provincia: ${ciudad['provincia']}"), 
              SizedBox(height: 10), 
              Text("Descripción: ${ciudad['descripcion']}"), // Descripción de la ciudad 
              SizedBox(height: 10), 
              Text("Población: ${ciudad['detalles']['poblacion']}"), // Población 
              Text("Altitud: ${ciudad['detalles']['altitud']}"), // Altitud 
              SizedBox(height: 10), 
              Text("Sitio Web: ${ciudad['informacion']['sitio_web']}"), // Sitio web 
              Text("Mapa: ${ciudad['informacion']['mapa']}"), // Mapa 
            ], 
          ), 
          actions: <Widget>[ 
            TextButton( 
              onPressed: () { 
                Navigator.of(context).pop(); 
              }, 
              child: Text('Cerrar'), 
            ), 
          ], 
        ); 
      }, 
    ); 
  } 
}