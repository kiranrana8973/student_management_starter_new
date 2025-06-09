import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentRepository {
  Future<Either<Failure, void>> registerStudent(StudentEntity student);

  Future<Either<Failure, String>> loginStudent(
    String username,
    String password,
  );

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, StudentEntity>> getCurrentUser();
}
