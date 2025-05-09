import 'package:flutter/material.dart';
import 'package:practica2/models/tarea.dart';

class ListaTareas extends StatelessWidget {
  final List<Tarea> tareas;
  final Function(int) onEliminar;

  ListaTareas({required this.tareas, required this.onEliminar});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tareas.length,
      itemBuilder: (context, index) {
        final tarea = tareas[index];
        return ListTile(
          title: Text(tarea.nombre),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onEliminar(tarea.id!),
          ),
        );
      },
    );
  }
}
