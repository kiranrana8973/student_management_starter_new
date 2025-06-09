import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class RegisterUserParams extends Equatable {
  final String fname;
  final String lname;
  final String phone;
  final BatchEntity batch;
  final List<CourseEntity> courses;
  final String username;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fname,
    required this.lname,
    required this.phone,
    required this.batch,
    required this.courses,
    required this.username,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [
    fname,
    lname,
    phone,
    batch,
    courses,
    username,
    password,
  ];
}

class StudentRegisterUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IStudentRepository _studentRepository;

  StudentRegisterUsecase({required IStudentRepository studentRepository})
    : _studentRepository = studentRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final studentEntity = StudentEntity(
      fName: params.fname,
      lName: params.lname,
      phone: params.phone,
      batch: params.batch,
      courses: params.courses,
      username: params.username,
      password: params.password,
      image: params.image,
    );
    return _studentRepository.registerStudent(studentEntity);
  }
}
