import 'package:student_management/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseDataSource {
  Future<List<CourseEntity>> getCourses();
  Future<void> createCourse(CourseEntity course);
  Future<void> deleteCourse(String id);
}
