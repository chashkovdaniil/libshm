class Subject {
  int id;
  String title;
  String teacher = "";

  Subject({this.id, this.title, this.teacher});

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
    id: json['id'],
    title: json['title'],
    teacher: json['teacher']
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'teacher': teacher,
  };
}