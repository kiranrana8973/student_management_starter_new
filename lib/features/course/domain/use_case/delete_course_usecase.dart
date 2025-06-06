import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/course/domain/repository/course_repository.dart';

class DeleteCourseParams extends Equatable {
  final String id;

  const DeleteCourseParams({required this.id});

  const DeleteCourseParams.empty() : id = '_empty.string';

  @override
  List<Object?> get props => [id];
}

// Use case
class DeleteCourseUsecase
    implements UsecaseWithParams<void, DeleteCourseParams> {
  final ICourseRepository _courseRepository;

  DeleteCourseUsecase({required ICourseRepository courseRepository})
    : _courseRepository = courseRepository;

  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) {
    return _courseRepository.deleteCourse(params.id);
  }
}
