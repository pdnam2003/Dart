import 'package:smanage/models/subject.dart';

import '../services/student.service.dart';
import '../models/student.dart';

class StudentController {

  final StudentService _studentService;
  StudentController(this._studentService);

  void add(Student student){
    return _studentService.add(student);
  }

  List<Student> getAll(){
    return _studentService.getAll();
  }
  bool updateItem(Student student){
    return _studentService.updateItem(student);
  }
  bool deleteItem(String code){
    return _studentService.deleteItem(code);
  }
  Student? getByCode(String code){
    return _studentService.getByCode(code);
  }
  StatusStudent parseStatus(String input){
    return _studentService.parseStatus(input);
  }
  Student? getByName(String code){
    return _studentService.getByName(code);
  }
  List<Student> viewBan(){
    return _studentService.viewBan();
  }
  bool regisSub(String scode, List<Subject> subjects){
    return _studentService.regisSub(scode, subjects);
  }

}