import 'package:schooldiary/Models/Homework.dart';

class HomeworkPageArgs {
  final String title;
  final String content;
  final int idSubject;
  final int idShedule;
  final int date;
  final int grade;
  final Homework homework;
  final bool isDone;

  HomeworkPageArgs({this.title, this.content, this.homework, this.idShedule, this.idSubject, this.date, this.grade, this.isDone});
}