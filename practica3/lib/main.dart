import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica3/models/tarea.dart';
import 'package:practica3/widgets/entrada_tarea.dart';
import 'package:practica3/widgets/lista_tarea.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(TareaAdapter());
  await Hive.openBox<Tarea>('tareas');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: ListaTareasScreen(),
    );
  }
}

class ListaTareasScreen extends StatefulWidget {
  @override
  State<ListaTareasScreen> createState() => _ListaTareasScreenState();
}

class _ListaTareasScreenState extends State<ListaTareasScreen> {
  final Box<Tarea> box = Hive.box<Tarea>('tareas');

  void _agregarTarea(String nombre) {
    if (nombre.isNotEmpty) {
      final tarea = Tarea(id: box.length, nombre: nombre);
      box.add(tarea);
    }
  }

  void _eliminarTarea(int index) {
    box.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: Column(
        children: [
          EntradaTarea(
            onAgregarTarea: _agregarTarea,
          ),
          Expanded(
            child: ListaTareas(
              box: box,
              onEliminarTarea: _eliminarTarea,
            ),
          ),
        ],
      ),
    );
  }
}
