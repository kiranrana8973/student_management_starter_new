import 'package:equatable/equatable.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class StudentEntity extends Equatable {
  final String? studentId;
  final String fName;
  final String lName;
  final String? image;
  final String phone;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String username;
  final String password;

  const StudentEntity({
    this.studentId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    studentId,
    fName,
    lName,
    image,
    batch,
    phone,
    courses,
    username,
    password,
  ];
}
