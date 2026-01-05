import '../models/subject.dart';
import '../interface/base.interface.dart';
import 'package:collection/collection.dart';
class SubjectService implements IBaseInterface<Subject, String> {
  List<Subject> subjects = [];
  SubjectService(this.subjects);
  
  @override
  void add(Subject subject) {
    bool isSubjectExists = subjects.any((s) => s.code == subject.code);
    if (isSubjectExists) {
      throw Exception('Subject $subject da co');
    }
    bool checkName = subjects.any((c) => c.name == subject.name);
    if (checkName) {
      throw Exception('Subject name ${subject.name} da co');
    }
    bool checkCredits = subject.credits <= 1 || subject.credits > 15;
    if (checkCredits) {
      throw Exception('So tin chi khong hop le');
    }

    subjects.add(subject);
  }
  
  @override
  Subject? getByName(String keyword) {
    return subjects.firstWhereOrNull(
        (s) => s.name.trim().toLowerCase() == keyword.trim().toLowerCase());
  }
  
  @override
  Subject? getByCode(String keyword) {
    return subjects.firstWhereOrNull(
        (s) => s.code.trim().toLowerCase() == keyword.trim().toLowerCase());
  }

  @override
  bool updateItem(Subject updateSubject){
    final index = subjects.indexWhere((s)=>s.code.trim().toLowerCase() == updateSubject.code.trim().toLowerCase());
    if(index == -1){
      throw Exception('Subject khong ton tai');
    }
    subjects[index] = updateSubject;
    return true;

  }
  
  @override
  bool deleteItem(String code){
    final index = subjects.indexWhere((s)=>s.code.trim().toLowerCase() == code.trim().toLowerCase());
    if(index == -1){
      throw Exception('Subject khong ton tai');
    }
    subjects.removeAt(index);
    return true;

  }
  
  @override
  List<Subject> getAll() {
    return subjects;
  }
 
  List<Subject> selectSub(String input,List<Subject> subject){
   
    List<Subject> danghoc = [];
    List<String> index= input.split(',');

    for(var i in index){
      int ind = int.parse(i.trim())-1;
      
      if(ind >=0 && ind < subjects.length){
        Subject subject = subjects[ind];
       
        bool exists = danghoc.any((a)=>a.code == subject.code);
      if(!exists){
        danghoc.add(subject);
      }else{
        throw Exception('khong hop le');
      }      
      }      
    }
    print(danghoc);
    return danghoc;
  }



}
