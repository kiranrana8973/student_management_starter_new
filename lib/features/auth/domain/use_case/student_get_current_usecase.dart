import 'package:dartz/dartz.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/entity/student_entity.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class StudentGetCurrentUsecase implements UsecaseWithoutParams<StudentEntity> {
  final IStudentRepository _studentRepository;

  StudentGetCurrentUsecase({required IStudentRepository studentRepository})
    : _studentRepository = studentRepository;

  @override
  Future<Either<Failure, StudentEntity>> call() {
    return _studentRepository.getCurrentUser();
  }
}
