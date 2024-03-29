import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import './Models/Subject.dart';
import './Models/Homework.dart';
import './Models/Shedule.dart';

List weekdayString = ['monday', 'tuesday', 'wednessday', 'thursday', 'friday', 'saturday', 'sunday'];

class DBProvider {
  static final DBProvider db = DBProvider._();
  Database _database;
  
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "DB.db");

    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onOpen: (db) {}, 
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE subjects (id INTEGER PRIMARY KEY, title TEXT, teacher TEXT)");
        await db.execute("CREATE TABLE homeworks ("
            "id INTEGER PRIMARY KEY,"
            "date int,"
            "idShedule int,"
            "subject int,"
            "content TEXT,"
            "files TEXT,"
            "grade int,"
            "isDone int DEFAULT 0)");
        await db.execute('CREATE TABLE IF NOT EXISTS shedule (id INTEGER PRIMARY KEY, weekday int, week int, subject int)');
    });
  }
  updateBase() async {
    /// final db = await database;
    ///
  }


  // Shedule

  Future<List<Shedule>> getShedule({int weekday, int week = 1}) async {
    final db = await database;
    var res = await db.query('shedule', where: 'weekday = ? AND week = ?', whereArgs: [weekday-1, week]);
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return list;
  }

  Future<Map<String, dynamic>> getSheduleAndSubjects({int weekday, int week = 1}) async {
    final db = await database;
    var res = await db.query('shedule', where: 'weekday = ? AND week', whereArgs: [weekday-1, week]);
    var subjects = await db.query("subjects");
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return {'shedule': list, 'subjects': subjects};
  }

  addShedule({int weekday, int week = 1, Shedule shedule}) async {
    final db = await database;
    var raw = db.rawInsert("INSERT INTO shedule (weekday, week, subject) VALUES (?, ?, ?)", [weekday-1, week, shedule.subject]);
    return raw;
  }
  updateShedule({int weekday, Shedule shedule}) async {
    final db = await database;
    var raw = await db.update('shedule', shedule.toMap(), where: 'id = ?', whereArgs: [shedule.id]);
    return raw;
  }
  deleteShedule({int id, int weekday}) async {
    final db = await database;
    var homeworks = await db.query('homeworks', where: "idShedule = ?", whereArgs: [id]);

    if (homeworks.length > 0) {
      homeworks.forEach((item){
        db.delete("homeworks", where: "id = ?", whereArgs: [item['id']]);
      });
    }

    var raw = db.delete('shedule', where: "id = ?", whereArgs: [id]);
    return {'query': raw, 'done': 1};
  }
  Future<List<Shedule>> getMaxId({int weekday, int week = 1}) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM shedule WHERE weekday = ${weekday-1} AND week = $week ORDER BY id DESC LIMIT 1');
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return list;
  }

  // ----------------------- Homeworks

  Future<Map<String, dynamic>> getSH({int weekday, int date}) async {
    final db = await database;
    var homeworks = await db.query("homeworks", where: 'date = ?', whereArgs: [date]);
    var shedule = await DBProvider.db.getShedule(weekday: weekday);

    List<Homework> listHomeworks = homeworks.isNotEmpty ? homeworks.map((data)=>Homework.fromMap(data)).toList() : [];
    return {
      'shedule': shedule,
      'homeworks': listHomeworks
    };
  }
  Future<List<Homework>> getNotDoneHomeworks() async {
    final db = await database;
    var res = await db.query('homeworks', where: 'isDone = 0 AND content != ""');
    List<Homework> list = res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList() : [];
    return list;
  }
  Future<List<Homework>> getHomeWorks(int date) async {
    final db = await database;
    var res = await db.query("homeworks", where: 'date = ?', whereArgs: [date]);
    List<Homework> list =  res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList() : [];
    return list;
  }
  homework({Homework homework}) async {
    final db = await database;
    var raw;

    if (homework.id == null) {
      var idMax = await db.rawQuery("SELECT * FROM homeworks ORDER BY id DESC LIMIT 1");
      int id = 1;
      if (idMax.length > 0) {
        id = idMax[0]['id']+1;
      }

      return raw = db.rawInsert(
        "INSERT Into homeworks (id, content, idShedule, subject, date, grade, isDone)"
        " VALUES (?, ?, ?, ?, ?, ?, ?)",
        [id, homework.content, homework.idShedule, homework.subject, homework.date, homework.grade, homework.isDone]
      );
    }
    raw = await db.update('homeworks', homework.toMap(), where: 'id = ?', whereArgs: [homework.id]);
    return raw;
  }

  // ----------------------- Subejcts

  Future<List<Subject>> getSubjects() async {
    final db = await database;
    var res = await db.query("subjects");
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    return list;
  }
  Future<List<Subject>> getSubject(int id) async{
    final db = await database;
    var res = await db.query("subjects", where: 'id = ?', whereArgs: [id]);
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    return list;
  }
  addSubject(Subject subject) async{
    final db = await database;
    List isExist = await db.query('subjects', where: 'title = ?', whereArgs: [subject.title]);
    var raw = {'done': 0, 'msg': 'Такой уже есть'};
    if (isExist.length == 0) {
      var query = db.rawInsert(
        "INSERT Into subjects (title, teacher)"
        " VALUES (?, ?)",
        [subject.title, subject.teacher]
      );
      raw = {'done': 1, 'msg': 'Добавлено', 'query': query};
    }
    return raw;
  }
  deleteSubject(int id) async{
    final db = await database;
    
    var shedule = await db.query('shedule', where: "subject = ?", whereArgs: [id]);
    if (shedule.length > 0) {
      for(var k = 0; k < shedule.length; k++){
        await DBProvider.db.deleteShedule(id: shedule[k]['id']);
      }
    }
    var raw = db.delete("subjects", where: "id = ?", whereArgs: [id]);
    return raw;
  }
  updateSubject(Subject subject) async {
    final db = await database;
    var raw = await db.update("subjects", subject.toMap(), where: 'id = ?', whereArgs: [subject.id]);
    return raw;
  }

  Future<List<Homework>> getGrades(int subject) async {
    final db = await database;
    var res = await db.query('homeworks', where: 'subject = ?', whereArgs: [subject]);
    List<Homework> list = res.isNotEmpty ? res.map( (data) => Homework.fromMap(data) ).toList() : [];
    return list;
  }
}