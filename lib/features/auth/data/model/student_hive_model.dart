import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/app/constant/hive_table_constant.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'student_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.studentTableId)
class StudentHiveModel extends Equatable {
  @HiveField(0)
  final String? studentId;
  @HiveField(1)
  final String fName;
  @HiveField(2)
  final String lName;
  @HiveField(3)
  final String? image;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final BatchHiveModel batch;
  @HiveField(6)
  final List<CourseHiveModel> courses;
  @HiveField(7)
  final String username;
  @HiveField(8)
  final String password;

  StudentHiveModel({
    String? studentId,
    required this.fName,
    required this.lName,
    this.image,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
  }) : studentId = studentId ?? const Uuid().v4();

  // Initial Constructor
  const StudentHiveModel.initial()
    : studentId = '',
      fName = '',
      lName = '',
      image = '',
      phone = '',
      batch = const BatchHiveModel.initial(),
      courses = const [],
      username = '',
      password = '';

  // From Entity
  factory StudentHiveModel.fromEntity(StudentEntity entity) {
    return StudentHiveModel(
      studentId: entity.studentId,
      fName: entity.fName,
      lName: entity.lName,
      image: entity.image,
      phone: entity.phone,
      batch: BatchHiveModel.fromEntity(entity.batch),
      courses: CourseHiveModel.fromEntityList(entity.courses),
      username: entity.username,
      password: entity.password,
    );
  }

  // To Entity
  StudentEntity toEntity() {
    return StudentEntity(
      studentId: studentId,
      fName: fName,
      lName: lName,
      image: image,
      phone: phone,
      batch: batch.toEntity(),
      courses: CourseHiveModel.toEntityList(courses),
      username: username,
      password: password,
    );
  }

  @override
  List<Object?> get props => [
    studentId,
    fName,
    lName,
    image,
    batch,
    courses,
    username,
    password,
  ];
}
