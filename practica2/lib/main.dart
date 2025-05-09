import 'package:flutter/material.dart';
import 'db/db_helper.dart';
import 'models/tarea.dart';
import 'widgets/entrada_tarea.dart';
import 'widgets/lista_tarea.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      home: TareaScreen(),
    );
  }
}

class TareaScreen extends StatefulWidget {
  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  List<Tarea> _tareas = [];
  final TextEditingController _controller = TextEditingController();

  void _cargarTareas() async {
    final tareas = await DBHelper.obtenerTareas();
    setState(() {
      _tareas = tareas;
    });
  }

  void _agregarTarea() async {
    if (_controller.text.isNotEmpty) {
      await DBHelper.insertarTarea(Tarea(nombre: _controller.text));
      _controller.clear();
      _cargarTareas();
    }
  }

  void _eliminarTarea(int id) async {
    await DBHelper.eliminarTarea(id);
    _cargarTareas();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cargarTareas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Tareas'),
      ),
      body: Column(
        children: [
          EntradaTarea(controlador: _controller, onAgregar: _agregarTarea),
          Expanded(
              child: ListaTareas(tareas: _tareas, onEliminar: _eliminarTarea)),
        ],
      ),
    );
  }
}
