import 'package:hello_world/Models/Homework.dart';

class HomeworkPageArgs {
  final String title;
  final String content;
  final int idSubject;
  final int date;
  final int grade;
  final Homework homework;

  HomeworkPageArgs({this.title, this.content, this.homework, this.idSubject, this.date, this.grade});
}