
class Homework {
  int id;
  int subject;
  int grade;
  bool isDone;
  String content;
  List files;
  int date;

  Homework({this.id, this.date, this.subject, this.content, this.grade, this.isDone = false});
  
  factory Homework.fromMap(Map<String, dynamic> json) => new Homework(
    id: json['id'],
    date: json['date'],
    subject: json['subject'],
    content: json['content'],
    grade: json['grade'],
    isDone: json['isDone'] == 1,
    // files: json['files']
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'subject': subject,
    'content': content,
    'date': date,
    'grade': grade,
    'isDone': isDone ? 1 : 0
  };
}