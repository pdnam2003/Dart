import 'subject.dart';
enum StatusStudent {
 active,
 globalBan,
}
class Student {
  final String code;
  String name;
  String email;
  int age;
  StatusStudent status;
  
  List<Subject> enRollSubjects = [];

  Student({
    required this.code,
    required this.name,
    required this.email,
    required this.age,
    required this.enRollSubjects,
    required this.status,
  });
}