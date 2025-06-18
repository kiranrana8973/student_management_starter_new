import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/shared_pref/token_shared_prefs.dart';
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
  final TokenSharedPrefs _tokenSharedPrefs;

  DeleteCourseUsecase({
    required ICourseRepository courseRepository,
    required TokenSharedPrefs tokenSharedPrefs,
  }) : _courseRepository = courseRepository,
       _tokenSharedPrefs = tokenSharedPrefs;

  @override
  Future<Either<Failure, void>> call(DeleteCourseParams params) async {
    final token = await _tokenSharedPrefs.getToken();
    return token.fold(
      (failure) => Left(failure),
      (token) async => await _courseRepository.deleteCourse(params.id, token),
    );
  }
}
