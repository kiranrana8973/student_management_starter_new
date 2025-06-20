import 'package:dio/dio.dart';
import 'package:student_management/app/constant/api_endpoints.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/features/course/data/data_source/course_data_source.dart';
import 'package:student_management/features/course/data/dto/get_all_courses_dto.dart';
import 'package:student_management/features/course/data/model/course_api_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseRemoteDatasource implements ICourseDataSource {
  final ApiService _apiService;

  CourseRemoteDatasource({required ApiService apiService})
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
        // Successfully created course
        return;
      } else {
        // Handle unexpected status code
        throw Exception('Failed to create course: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to create course: $e');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> deleteCourse(String id, String? token) async {
    try {
      final response = await _apiService.dio.delete(
        '${ApiEndpoints.deleteCourse}/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        // Successfully deleted course
        return;
      } else {
        // Handle unexpected status code
        throw Exception('Failed to delete course: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to delete course: ${e}');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      final response = await _apiService.dio.get(ApiEndpoints.getAllCourse);

      if (response.statusCode == 200) {
        // Parse the response data
        final data = response.data as Map<String, dynamic>;
        final coursesDto = GetAllCoursesDto.fromJson(data);

        // Convert API model list to entity list
        return CourseApiModel.toEntityList(coursesDto.data);
      } else {
        // Handle unexpected status code
        throw Exception('Failed to fetch courses: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle DioException
      throw Exception('Failed to fetch courses: $e');
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
