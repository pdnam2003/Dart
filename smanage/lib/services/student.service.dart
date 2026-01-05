import '../models/student.dart';
import '../models/subject.dart';
import '../interface/base.interface.dart';
import 'package:collection/collection.dart';

class StudentService implements IBaseInterface<Student, String> {
  List<Student> students = [];
  StudentService(this.students);

  @override
  void add(Student student) {
    bool isEmailExists = students.any(
      (s) => s.email.trim().toLowerCase() == student.email.trim().toLowerCase(),
    );
    if (isEmailExists) {
      throw Exception('Email ${student.email} da co');
    }

    bool isCodeExists = students.any(
      (s) => s.code.trim().toLowerCase() == student.code.trim().toLowerCase(),
    );
    if (isCodeExists) {
      throw Exception('Code ${student.code} da co');
    }

    bool checkAge = student.age < 18;
    if (checkAge) {
      throw Exception('Tuoi khong hop le');
    }
    bool checkBan = student.status == StatusStudent.globalBan;
    if (checkBan) {
      throw Exception('Student da bi duoi hoc');
    }

    students.add(student);
  }

  @override
  Student? getByName(String keyword) {
    return students.firstWhereOrNull(
      (s) => s.name.trim().toLowerCase() == keyword.trim().toLowerCase(),
    );
  }

  @override
  Student? getByCode(String keyword) {
    return students.firstWhereOrNull(
      (s) => s.code.trim().toLowerCase() == keyword.trim().toLowerCase(),
    );
  }

  @override
  List<Student> getAll() {
    return students;
  }

  @override
  bool updateItem(Student upstudent) {
    final index = students.indexWhere(
      (s) => s.code.trim().toLowerCase() == upstudent.code.trim().toLowerCase(),
    );
    if (index == -1) {
      return false;
    }

    students[index] = upstudent;
    return true;
  }

  @override
  bool deleteItem(String code) {
    final index = students.indexWhere(
      (s) => s.code.trim().toLowerCase() == code.trim().toLowerCase(),
    );
    if (index == -1) {
      return false;
    }

    students.removeAt(index);
    return true;
  }

  StatusStudent parseStatus(String input) {
    switch (input) {
      case '1':
        return StatusStudent.active;
      case '2':
        return StatusStudent.globalBan;
      default:
        print('Không hợp lệ');
        throw Exception('Trạng thái không hợp lệ');
    }
  }

  List<Student> viewBan() {
    return  students.where((e)=>e.status == StatusStudent.globalBan,).toList();
  }

  bool regisSub(String scode, List<Subject> subjects){
    final std = students.firstWhereOrNull((s)=>s.code.toLowerCase() == scode.trim().toLowerCase());
    if(std==null){
      throw Exception("khong thay sv ");
    }
    if(std.status == StatusStudent.globalBan){
      print("sv da duoi hoc");
    }
    for(var i in subjects){
      final regisSubject = std.enRollSubjects.any((s)=>s.code == i.code);
    
    if(!regisSubject){
      std.enRollSubjects.add(i);
    }}

    return true;
  }


}
