import 'package:flutter/material.dart';
import '../models/tarea.dart';

class ListaTareasWidget extends StatelessWidget {
  final List<Tarea> tareas;
  final Function(int) onEliminar;

  const ListaTareasWidget({
    super.key,
    required this.tareas,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: tareas.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            tareas[index].titulo,
            style: TextStyle(
              decoration: tareas[index].complementada
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: IconButton(
            onPressed: () => onEliminar(index),
            icon: Icon(Icons.delete),
          ),
          onTap:() {
            tareas[index].complementada = !tareas[index].complementada;
          },
        ),
      ),
    );
  }
}
