import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

abstract interface class ICourseRepository {
  Future<Either<Failure, List<CourseEntity>>> getCourses();
  Future<Either<Failure, void>> createCourse(CourseEntity course);
  Future<Either<Failure, void>> deleteCourse(String id, String? token);
}
