import './controller/student.controller.dart';
import './controller/subject.controller.dart';
import './models/student.dart';
import './models/subject.dart';
import './services/student.service.dart';
import './services/subject.service.dart';

import 'dart:io';

void main() {
  List<Subject> subjectsData = [
    Subject(code: "1", name: "Toan Cao Cap", credits: 3),
    Subject(code: "2", name: "Ly 1", credits: 2),
    Subject(code: "3", name: "Hoa Hoc", credits: 3),
    Subject(code: "4", name: "Van Hoc", credits: 2),
    Subject(code: "5", name: "Tin Hoc", credits: 3),
  ];
  List<Student> studentsData = [
    Student(
      code: "S001",
      name: "Tran Hieu",
      email: "h@gmail.com",
      age: 20,
      enRollSubjects: [subjectsData[0], subjectsData[2]],
      status: StatusStudent.active,
    ),
    Student(
      code: "S002",
      name: "Le Van A",
      email: "a@gmail.com",
      age: 21,
      enRollSubjects: [subjectsData[1], subjectsData[4]],
      status: StatusStudent.active,
    ),
    Student(
      code: "S003",
      name: "Le Thi B",
      email: "b@gmail.com",
      age: 19,
      enRollSubjects: [subjectsData[0], subjectsData[1], subjectsData[3]],
      status: StatusStudent.globalBan,
    ),
    Student(
      code: "S004",
      name: "Le Van C",
      email: "c@gmail.com",
      age: 22,
      enRollSubjects: [subjectsData[2], subjectsData[4]],
      status: StatusStudent.globalBan,
    ),
  ];
  final studentService = StudentService(studentsData);
  final studentController = StudentController(studentService);
  final subjectService = SubjectService(subjectsData);
  final subjectController = SubjectController(subjectService);

  final isRun = true;

  while (isRun) {
    print('===== MENU QUẢN LÝ SINH VIÊN =====');
    print('1. Thêm sinh viên');
    print('2. Hiển thị danh sách sinh viên');
    print('3. Tìm sinh viên theo mã / tên / email');
    print('4. Cập nhật sinh viên theo ten');
    print('5. Xóa sinh viên theo ten');
    print('6. Xem sinh viên bị đuổi học');
    print('7. Đăng ký môn học yêu thích');
    print('0. Thoát');
    print('---------------------------------');
    stdout.write('Chọn chức năng: ');

    final choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        print('Bạn chọn: Thêm sinh viên');
        stdout.write('Nhập mã SV: ');
        String code = stdin.readLineSync()!;

        stdout.write('Nhập tên: ');
        String name = stdin.readLineSync()!;

        stdout.write('Nhập email: ');
        String email = stdin.readLineSync()!;

        stdout.write('Nhập tuổi: ');
        int age = int.parse(stdin.readLineSync()!);

        stdout.write('nhap trang thai :');
        print('\n1. Đang học');
        print('2. Bị đuổi học');
        stdout.write('lua chon : ');
        String statusInput = stdin.readLineSync()!;
        StatusStudent status;
        status = studentController.parseStatus(statusInput);

        print('Danh sách môn học:');
        for (int i = 0; i < subjectsData.length; i++) {
          print('${i + 1}. ${subjectsData[i].name}');
        }
        stdout.write('Nhập STT các môn đang học (vd: 1,3,5): ');
        String inputSubjects = stdin.readLineSync()!;
        List<Subject> danghoc;

        danghoc = subjectController.selectSub(inputSubjects, subjectsData);

        Student studentsData = Student(
          code: code,
          name: name,
          email: email,
          age: age,
          status: status,
          enRollSubjects: subjectsData,
        );

        studentController.add(studentsData);
        break;

      case '2':
        print('Bạn chọn: Hiển thị danh sách sinh vien');
        final students = studentController.getAll();
        if (students.isEmpty) {
          print('khong co sinh vien');
        } else {
          for (var s in students) {
            print('Mã SV   : ${s.code}');
            print('Tên     : ${s.name}');
            print('Email   : ${s.email}');
            print('Tuổi    : ${s.age}');
            print(
              'Trạng thái: ${s.status == StatusStudent.active ? "Đang học" : "Bị đuổi"}',
            );
            print('Môn học: ${s.enRollSubjects.map((e) => e.name).join(", ")}');
          }
        }
        break;

      case '3':
        print('Bạn chọn: Tìm sinh viên theo ma');
        print('nhap ma sv :');
        String inputCode = stdin.readLineSync()!;
        final student = studentController.getByCode(inputCode);
        if (student == null) {
          print('khong thay sv nao ca');
        } else {
          print('Mã SV   : ${student.code}');
          print('Tên     : ${student.name}');
          print('Email   : ${student.email}');
          print('Tuổi    : ${student.age}');
          print(
            'Trạng thái: ${student.status == StatusStudent.active ? "Đang học" : "Bị đuổi"}',
          );
          print(
            'Môn học: ${student.enRollSubjects.map((e) => e.name).join(", ")}',
          );
        }
        break;

      case '4':
        print('ban da chon cap nhap sv theo ten');
        print('nhap ten sv:');
        String inputName = stdin.readLineSync()!;
        final student = studentController.getByName(inputName);
        if (student == null) {
          print('khong thay vn ban nhap ten');
        } else {
          final upstudent = studentController.updateItem(student);
          print('nhap thong tin lan luot de cap nhap moi');
          stdout.write('Nhập mã SV: ');
          String code = stdin.readLineSync()!;

          stdout.write('Nhập tên: ');
          String name = stdin.readLineSync()!;

          stdout.write('Nhập email: ');
          String email = stdin.readLineSync()!;

          stdout.write('Nhập tuổi: ');
          int age = int.parse(stdin.readLineSync()!);

          stdout.write('nhap trang thai :');
          print('\n1. Đang học');
          print('2. Bị đuổi học');
          stdout.write('lua chon : ');
          String statusInput = stdin.readLineSync()!;
          StatusStudent status;
          status = studentController.parseStatus(statusInput);

          print('Danh sách môn học:');
          for (int i = 0; i < subjectsData.length; i++) {
            print('${i + 1}. ${subjectsData[i].name}');
          }
          stdout.write('Nhập STT các môn đang học (vd: 1,3,5): ');
          String inputSubjects = stdin.readLineSync()!;
          List<Subject> danghoc;
          danghoc = subjectController.selectSub(inputSubjects, subjectsData);

          Student studentsData = Student(
            code: code,
            name: name,
            email: email,
            age: age,
            status: status,
            enRollSubjects: subjectsData,
          );

          studentController.add(studentsData);
        }
        break;

      case '5':
        print('ban da chon xoa sv theo ten ');
        print('nhap ten sv:');
        String input = stdin.readLineSync()!;
        final student = studentController.getByName(input);
        if (student == null) {
          print('khong thay sinh vien ');
        } else {
          final delSv = studentController.deleteItem(student.code);
          if (delSv) {
            print('xoa thanh cong');
          } else {
            print('xoa that bai');
          }
        }
        break;
      case '6':
        print('ban chon xem sv bi duoi hoc');
        final banS = studentController.viewBan();
        if (banS.isEmpty) {
          print('khong co sv nao bi duoi');
        } else {
          for (var s in banS) {
            print('Mã SV   : ${s.code}');
            print('Tên     : ${s.name}');
            print('Email   : ${s.email}');
            print('Tuổi    : ${s.age}');
            print('Trạng thái: ${s.status}');
            print('Môn học: ${s.enRollSubjects.map((e) => e.name).join(", ")}');
          }
        }
        break;
      case '7':
        print('ban chon Đăng ký môn học yêu thích');
        print('nhap ten sv muon dk mon hoc');
        String inputName = stdin.readLineSync()!;
        final student = studentController.getByName(inputName);
        if (student == null) {
          print('khong thay sv nao ca');
        } else if (student.status == StatusStudent.globalBan) {
          print('bi ban khong cho hoc');
        } else {
          stdout.write('Nhập STT các môn dk học (vd: 1,3,5): ');
          String inputSubjects = stdin.readLineSync()!;
          final selectsubject = subjectController.selectSub(
            inputSubjects,
            subjectsData,
          );
          print(selectsubject);
          final regisSubject = studentController.regisSub(
            student.code,
            selectsubject,
          );

          if (regisSubject) {
            print('dang ky mon hoc thanh cong');
          }
        }

        break;

        case '0':
        return;
      default:
        print('Lựa chọn không hợp lệ');
    }

    print('\nNhấn Enter để tiếp tục...');
    stdin.readLineSync();
  }
}
