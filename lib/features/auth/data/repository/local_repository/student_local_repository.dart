import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class StudentLocalRepository implements IStudentRepository {
  final StudentLocalDatasource _studentLocalDatasource;

  StudentLocalRepository({
    required StudentLocalDatasource studentLocalDatasource,
  }) : _studentLocalDatasource = studentLocalDatasource;

  @override
  Future<Either<Failure, StudentEntity>> getCurrentUser() async {
    // TODO: implement loginStudent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginStudent(
    String username,
    String password,
  ) async {
    try {
      final result = await _studentLocalDatasource.loginStudent(
        username,
        password,
      );
      return Right(result);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerStudent(StudentEntity student) async {
    try {
      await _studentLocalDatasource.registerStudent(student);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to register: $e"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
