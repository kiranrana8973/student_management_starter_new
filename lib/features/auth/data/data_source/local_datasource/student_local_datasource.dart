import 'dart:io';

import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/data/data_source/sudent_data_source.dart';
import 'package:student_management/features/auth/data/model/student_hive_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

class StudentLocalDatasource implements IStudentDataSource {
  final HiveService _hiveService;

  StudentLocalDatasource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      final studentData = await _hiveService.login(username, password);
      if (studentData != null && studentData.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<void> registerStudent(StudentEntity student) async {
    try {
      // Convert StudentEntity to Hive model if necessary
      final studentHiveModel = StudentHiveModel.fromEntity(student);
      await _hiveService.register(studentHiveModel);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<StudentEntity> getCurrentUser() async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
