import 'dart:io';
import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/auth/data/data_source/sudent_data_source.dart';
import 'package:student_management/features/auth/data/model/student_api_model.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';

class StudentRemoteDataSource implements IStudentDataSource {
  final ApiService _apiService;
  StudentRemoteDataSource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<String> loginStudent(String username, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to login student: ${e.message}');
    } catch (e) {
      throw Exception('Failed to login student: $e');
    }
  }

  @override
  Future<void> registerStudent(StudentEntity studentData) async {
    try {
      final studentApiModel = StudentApiModel.fromEntity(studentData);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: studentApiModel.toJson(),
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
          'Failed to register student: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to register student: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register student: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await _apiService.dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload profile picture: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }

  @override
  Future<StudentEntity> getCurrentUser() {
    throw UnimplementedError();
  }
}
