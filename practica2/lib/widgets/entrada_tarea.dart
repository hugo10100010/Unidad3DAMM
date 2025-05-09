import 'package:flutter/material.dart';

class EntradaTarea extends StatelessWidget {
  final TextEditingController controlador;
  final VoidCallback onAgregar;

  const EntradaTarea({
    super.key,
    required this.controlador,
    required this.onAgregar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controlador,
              decoration: InputDecoration(labelText: 'Nueva Tarea'),
            ),
          ),
          IconButton(
            onPressed: onAgregar,
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
