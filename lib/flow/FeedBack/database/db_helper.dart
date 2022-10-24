import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../bulkFeedbackModel.dart';

class DatabaseHelper {
  static final _databaseName = 'feedback.db';
  static final _databseVersion = 1;

  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE feedbacks(id INTEGER PRIMARY KEY AUTOINCREMENT, orderCode TEXT NOT NULL, foodTaste INTEGER NOT NULL, environment INTEGER NOT NULL, service INTEGER NOT NULL, staffBehaviour INTEGER NOT NULL, comment TEXT NOT NULL, phone TEXT NOT NULL)',
    );
  }

  Future<void> insertFeedback(Feedbackk feedbackk) async {
    Database? db = await instance.database;
    await db!.insert(
      'feedbacks',
      feedbackk.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  List<Map<String, dynamic>>? feedbacksMap;
  Future<List<Feedbackk>> allFeedbacksFromDB() async {
    final db = await instance.database;

    // final List<Map<String, dynamic>>
    feedbacksMap = await db!.query('feedbacks');

    print(
        'this is a list of map for database saved feedbacks-=-=-=-=---==-=--=-= $feedbacksMap');
    return List.generate(feedbacksMap!.length, (index) {
      return Feedbackk(
        id: feedbacksMap![index]['id'],
        orderCode: feedbacksMap![index]['orderCode'],
        foodTaste: feedbacksMap![index]['foodTaste'],
        environment: feedbacksMap![index]['environment'],
        service: feedbacksMap![index]['service'],
        staffBehaviour: feedbacksMap![index]['staffBehaviour'],
        comment: feedbacksMap![index]['comment'],
        phone: feedbacksMap![index]['phone'],
      );
    });
  }

  Future<void> deleteAllFeedbacks() async {
    final db = await instance.database;
    await db!.delete('feedbacks');
  }
}
