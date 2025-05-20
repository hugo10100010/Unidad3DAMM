import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "REST Demo",
      home: TareasRest(),
    );
  }
}

class TareasRest extends StatefulWidget {
  @override
  State<TareasRest> createState() => _TareasRestState();
}

class _TareasRestState extends State<TareasRest> {
  List tareas = [];

  Future<void> obtenerTareas() async {
    try {
      final url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final datos = jsonDecode(respuesta.body);
        setState(() {
          tareas = datos.take(10).toList();
        });
      } else {
        print("Error en la respuesta: ${respuesta.statusCode}");
      }
    } catch (e) {
      print('Ocurrió un error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obtenerTareas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tareas desde REST"),
      ),
      body: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) {
          final tarea = tareas[index];
          return ListTile(
            title: Text(tarea['title']),
            trailing: Icon(
              tarea['completed'] ? Icons.check : Icons.close,
              color: tarea['completed'] ? Colors.green : Colors.red,
            ),
          );
        },
      ),
    );
  }
}
