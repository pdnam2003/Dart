import '../services/subject.service.dart';
import '../models/subject.dart';

class SubjectController {

  final SubjectService _subjectService;
  SubjectController(this._subjectService);

  void add(Subject student){
    return _subjectService.add(student);
  }

  List<Subject> getAll(){
    return _subjectService.getAll();
  }
  bool updateItem(Subject student){
    return _subjectService.updateItem(student);
  }
  bool deleteItem(String code){
    return _subjectService.deleteItem(code);
  }
  Subject? getByCode(String code){
    return _subjectService.getByCode(code);
  }
  List<Subject> selectSub(String  input){
    return _subjectService.selectSub(input);

  }


}