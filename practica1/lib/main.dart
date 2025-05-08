import 'package:flutter/material.dart';
import 'widgets/entrada_tarea.dart';
import 'widgets/lista_tareas.dart';
import 'models/tarea.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lista de Tareas',
      home: ListaTareas(),
    );
  }
}

class ListaTareas extends StatefulWidget {
  const ListaTareas({super.key});

  @override
  State<StatefulWidget> createState() => _ListaTareasState();
}

class _ListaTareasState extends State<ListaTareas> {
  final List<Tarea> _tareas = [];
  final TextEditingController _controlador = TextEditingController();

  void _agregarTarea() {
    if (_controlador.text.isNotEmpty) {
      setState(
        () {
          _tareas.add(Tarea(titulo: _controlador.text));
          _controlador.clear();
        },
      );
    }
  }

  void _eliminarTarea(int index) {
    setState(() {
      _tareas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tareas')),
      body: Column(
        children: [
          EntradaTarea(
            controlador: _controlador,
            onAgregar: _agregarTarea,
          ),
          ListaTareasWidget(
            tareas: _tareas,
            onEliminar: _eliminarTarea,
          ),
        ],
      ),
    );
  }
}
