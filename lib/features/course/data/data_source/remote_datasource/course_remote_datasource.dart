import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/course/data/data_source/course_data_source.dart';
import 'package:student_management/features/course/data/dto/get_all_course_dto.dart';
import 'package:student_management/features/course/data/model/course_api_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  final ApiService _apiService;
  CourseRemoteDataSource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<void> createCourse(CourseEntity course) async {
    try {
      final courseApiModel = CourseApiModel.fromEntity(course);
      final response = await _apiService.dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      final response = await _apiService.dio.delete(
        '${ApiEndpoints.deleteCourse}$id',
      );
      if (response.statusCode == 204) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      var response = await _apiService.dio.get(ApiEndpoints.getAllCourse);
      if (response.statusCode == 200) {
        // Convert API response to DTO
        var courseDTO = GetAllCourseDTO.fromJson(response.data);
        // Convert DTO to Entity
        return CourseApiModel.toEntityList(courseDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
