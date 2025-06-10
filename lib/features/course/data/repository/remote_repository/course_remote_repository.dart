import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/domain/repository/course_repository.dart';

class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource _courseRemoteDataSource;

  CourseRemoteRepository({
    required CourseRemoteDataSource courseRemoteDataSource,
  }) : _courseRemoteDataSource = courseRemoteDataSource;

  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) async {
    try {
      await _courseRemoteDataSource.createCourse(course);
      return Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) async {
    try {
      await _courseRemoteDataSource.deleteCourse(id);
      return Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() async {
    try {
      final courses = await _courseRemoteDataSource.getCourses();
      return Right(courses);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
