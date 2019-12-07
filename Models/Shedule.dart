class Shedule {
  int id;
  int subject;

  Shedule({this.id, this.subject});

  factory Shedule.fromMap(Map<String, dynamic> json) => Shedule(
    id: json['id'],
    subject: json['subject'],
  );
  Map<String, dynamic> toMap() => {
    'id': id,
    'subject': subject,
  };
}