import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:practica2/models/tarea.dart';

class DBHelper {
  static Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'tareas.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE tareas(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT)');
      },
    );
  }

  static Future<void> insertarTarea(Tarea tarea) async {
    final db = await initDB();
    await db.insert('tareas',tarea.toMap());
  }

  static Future<List<Tarea>> obtenerTareas() async {
    final db = await initDB();
    final List<Map<String,dynamic>> maps = await db.query('tareas');
    return List.generate(maps.length, (i) => Tarea.fromMap(maps[i]));
  }

  static Future<void> eliminarTarea(int id) async {
    final db = await initDB();
    await db.delete('tareas', where: 'id = ?', whereArgs:[id]);
  }
}
