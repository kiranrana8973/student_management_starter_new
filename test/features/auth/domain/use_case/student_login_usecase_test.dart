import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/auth/domain/use_case/student_login_usecase.dart';

import '../../../batch/domain/use_case/token.mock.dart';
import 'auth_repo.mock.dart';

void main() {
  late StudentRepoMock repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late StudentLoginUsecase usecase;

  setUp(() {
    repository = StudentRepoMock();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = StudentLoginUsecase(
      studentRepository: repository,
      tokenSharedPrefs: tokenSharedPrefs,
    );
  });

  test(
    'should call the [AuthRepo.login] with correct usename and password (kiran, kiran123)',
    () async {
      when(() => repository.loginStudent(any(), any())).thenAnswer((
        invocation,
      ) async {
        final username = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (username == 'kiran' && password == 'kiran123') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
            const Left(
              RemoteDatabaseFailure(message: 'Invalid username or password'),
            ),
          );
        }
      });

      when(
        () => tokenSharedPrefs.saveToken(any()),
      ).thenAnswer((_) async => Right(null));

      final result = await usecase(
        LoginParams(username: 'kiran', password: 'kiran123'),
      );

      expect(result, const Right('token'));

      verify(() => repository.loginStudent(any(), any())).called(1);
      verify(() => tokenSharedPrefs.saveToken(any())).called(1);

      verifyNoMoreInteractions(repository);
      verifyNoMoreInteractions(tokenSharedPrefs);
    },
  );

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
