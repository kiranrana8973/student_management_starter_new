import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockBatchRepository repository;
  late CreateBatchUsecase usecase;

  setUp(() {
    repository = MockBatchRepository();
    usecase = CreateBatchUsecase(batchRepository: repository);
    registerFallbackValue(BatchEntity.initial());
  });

  final params = CreateBatchParams.initial();

  test('should call the [BatchRepo.addBatch]', () async {
    when(() => repository.addBatch(any())).thenAnswer((_) async => Right(null));

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, Right(null));

    // Verify
    verify(() => repository.addBatch(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
