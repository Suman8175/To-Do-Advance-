import 'package:sqflite/sqflite.dart' as sql;
import 'package:todos/common/exception/exceptionshow.dart';
import 'package:todos/models/taskmodel.dart';

class DBHelper {
  static Future<void> createtable(sql.Database database) async {
    await database.execute("CREATE TABLE todos("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title String,desc TEXT,date STRING,"
        "starttime STRING,"
        "endtime STRING,"
        "remind INTEGER,repeat STRING,"
        "isCompleted INTEGER"
        ")");
    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
        "isVerified INTEGER"
        ")");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('todo', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createtable(database);
    });
  }

  static Future<int> createItems(TaskModel taskModel) async {
    final db = await DBHelper.db();

    final id = await db.insert('todos', taskModel.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<int> createUser(int isVerified) async {
    final db = await DBHelper.db();
    final data = {
      'id': 1,
      'isVerified': isVerified,
    };
    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    return id;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query('todos', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, String desc,
      int isCompleted, String date, String starttime, String endtime) async {
    final db = await DBHelper.db();
    final data = {
      "id": id,
      "title": title,
      "desc": desc,
      "isCompleted": isCompleted,
      "date": date,
      "starttime": starttime,
      "endtime": endtime,
    };
    final results =
        await db.update('todos', data, where: "id = ?", whereArgs: [id]);
    return results;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();
    try {
      db.delete('todos', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      ExceptionShower().showmessage(e.toString());
    }
  }
}
