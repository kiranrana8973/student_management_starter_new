import 'package:student_management/core/error/failure.dart';
import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/course/data/data_source/course_data_source.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseLocalDataSource implements ICourseDataSource {
  final HiveService _hiveService;

  CourseLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<void> createCourse(CourseEntity course) async {
    try {
      // Convert course entity to course model
      final courseHiveModel = CourseHiveModel.fromEntity(course);
      _hiveService.addCourse(courseHiveModel);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      _hiveService.deleteCourse(id);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }

  @override
  Future<List<CourseEntity>> getCourses() async {
    try {
      final courseHiveModelList = await _hiveService.getAllCourses();
      return CourseHiveModel.toEntityList(courseHiveModelList);
    } catch (e) {
      throw LocalDatabaseFailure(message: e.toString());
    }
  }
}
