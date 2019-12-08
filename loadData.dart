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

    await deleteDatabase(path);

    return await openDatabase(path, version: 1, onOpen: (db) {}, 
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE monday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE tuesday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE wednessday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE thursday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE friday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE saturday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE sunday ("
            "id INTEGER PRIMARY KEY,"
            "subject int)");
        await db.execute("CREATE TABLE subjects ("
            "id INTEGER PRIMARY KEY,"
            "title TEXT,"
            "teacher TEXT)");
        await db.execute("CREATE TABLE homeworks ("
            "id INTEGER PRIMARY KEY,"
            "date int,"
            "subject int,"
            "content TEXT,"
            "files TEXT,"
            "grade int,"
            "isDone int)");
    });
  }
  // Shedule
  Future<List<Shedule>> getShedule(int weekday) async {
    final db = await database;
    var res = await db.query(weekdayString[weekday-1]);
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return list;
  }

  Future<Map<String, dynamic>> getSheduleAndSubjects(int weekday) async {
    final db = await database;
    var res = await db.query(weekdayString[weekday-1]);
    var subjects = await db.query("subjects");
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return {'shedule': list, 'subjects': subjects};
  }
  
  addShedule({int weekday, Shedule shedule}) async {
    final db = await database;
    var raw = db.rawInsert("INSERT Into ${weekdayString[weekday-1]} (subject) VALUES (?)", [shedule.subject]);
    return raw;
  }
  updateShedule({int weekday, Shedule shedule}) async {
    final db = await database;
    var raw = await db.update(weekdayString[weekday-1], shedule.toMap(), where: 'id = ?', whereArgs: [shedule.id]);
    return raw;
  }
  deleteShedule({int id, int weekday}) async {
    final db = await database;
    var raw = db.delete(weekdayString[weekday-1], where: "id = ?", whereArgs: [id]);
    return raw;
  }
  Future<List<Shedule>> getMaxId({int weekday}) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM ${weekdayString[weekday-1]} ORDER BY id DESC LIMIT 1');
    List<Shedule> list =  res.isNotEmpty ? res.map((data) => Shedule.fromMap(data)).toList() : [];
    return list;
  }
  // Homeworks
  Future<Map<String, dynamic>> getSSH({int weekday, int date}) async {
    final db = await database;
    var homeworks = await db.query("homeworks", where: 'date = ?', whereArgs: [date]);
    var subjectsAndShedule = await DBProvider.db.getSheduleAndSubjects(weekday);

    List<Homework> listHomeworks = homeworks.isNotEmpty ? homeworks.map((data)=>Homework.fromMap(data)).toList() : [];
    return {
      'subjects': subjectsAndShedule['subjects'],
      'shedule': subjectsAndShedule['shedule'],
      'homeworks': listHomeworks
    };
  }
  Future<List<Homework>> getHomeWorks(int date) async {
    final db = await database;
    var res = await db.query("homeworks", where: 'date = ?', whereArgs: [date]);
    List<Homework> list =  res.isNotEmpty ? res.map((data) => Homework.fromMap(data)).toList() : [];
    return list;
  }
  homework({Homework homework, int idSubject, String content, int date}) async {
    final db= await database;
    var raw;
    List homeworks = await db.query("homeworks", where: 'date = ? AND subject = ?', whereArgs: [date, idSubject]);

    print(homework.toMap());
    if (homeworks.length == 0) {
      raw = db.rawInsert(
        "INSERT Into homeworks (content, subject, date, grade)"
        " VALUES (?, ?, ?, ?)",
        [homework.content, homework.subject, date, homework.grade]
      );
    } else {
      raw = await db.update('homeworks', homework.toMap(), where: 'id = ?', whereArgs: [homework.id]);
    }
    // print(homework.toMap());
    return raw;
  }
  // Subejcts
  Future<List<Subject>> getSubjects() async {
    final db = await database;
    var res = await db.query("subjects");
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    return list;
  }
  getSubject(int id) async{
    final db = await database;
    var res = await db.query("subjects", where: 'id = ?', whereArgs: [id]);
    List<Subject> list =  res.isNotEmpty ? res.map((data) => Subject.fromMap(data)).toList() : [];
    return list;
  }
  addSubject(Subject subject) async{
    final db = await database;
    if (subject.teacher == null) {
      subject.teacher = "";
    }
    var raw = db.rawInsert(
      "INSERT Into subjects (title, teacher)"
      " VALUES (?, ?)",
      [subject.title, subject.teacher]
    );
    return raw;
  }
  deleteSubject(int id) async{
    final db = await database;
    var raw = db.delete("subjects", where: "id = ?", whereArgs: [id]);
    return raw;
  }
  updateSubject(Subject subject) async {
    final db = await database;
    var raw = await db.update("subjects", subject.toMap(), where: 'id = ?', whereArgs: [subject.id]);
    return raw;
  }
}