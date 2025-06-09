import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/repository/student_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({required this.username, required this.password});

  // Initial Constructor
  const LoginParams.initial() : username = '', password = '';
  @override
  List<Object?> get props => [username, password];
}

class StudentLoginUsecase implements UsecaseWithParams<String, LoginParams> {
  final IStudentRepository _studentRepository;

  StudentLoginUsecase({required IStudentRepository studentRepository})
    : _studentRepository = studentRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _studentRepository.loginStudent(
      params.username,
      params.password,
    );
  }
}
