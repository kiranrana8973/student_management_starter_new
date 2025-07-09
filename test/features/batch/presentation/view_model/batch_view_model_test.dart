import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';

class MockCreateBatchUseCase extends Mock implements CreateBatchUsecase {}

class MockGetAllBatchUseCase extends Mock implements GetAllBatchUsecase {}

class MockDeleteBatchUsecase extends Mock implements DeleteBatchUsecase {}

void main() {
  late CreateBatchUsecase createBatchUseCase;
  late GetAllBatchUsecase getAllBatchUseCase;
  late DeleteBatchUsecase deleteBatchUseCase;
  late BatchViewModel batchViewModel;

  setUp(() {
    createBatchUseCase = MockCreateBatchUseCase();
    getAllBatchUseCase = MockGetAllBatchUseCase();
    deleteBatchUseCase = MockDeleteBatchUsecase();

    batchViewModel = BatchViewModel(
      getAllBatchUsecase: getAllBatchUseCase,
      createBatchUsecase: createBatchUseCase,
      deleteBatchUsecase: deleteBatchUseCase,
    );
  });

  group('BatchViewModel', () {
    final batch = BatchEntity(batchId: '1', batchName: 'Batch 1');
    final batch2 = BatchEntity(batchId: '2', batchName: 'Batch 2');
    final lstBatches = [batch, batch2];

    blocTest<BatchViewModel, BatchState>(
      'emits [BatchState] with loaded batches when LoadBatches is added',
      build: () {
        when(
          () => getAllBatchUseCase.call(),
        ).thenAnswer((_) async => Right(lstBatches));
        return batchViewModel;
      },
      act: (bloc) => bloc.add(LoadBatchesEvent()),
      expect: () => [
        BatchState.initial().copyWith(isLoading: true),
        BatchState.initial().copyWith(isLoading: false, batches: lstBatches),
      ],
      verify: (_) {
        verify(() => getAllBatchUseCase.call()).called(1);
      },
    );

    blocTest<BatchViewModel, BatchState>(
      'emits [BatchState] with loaded batches when LoadBatches is added with skip 1',
      build: () {
        when(
          () => getAllBatchUseCase.call(),
        ).thenAnswer((_) async => Right(lstBatches));
        return batchViewModel;
      },
      act: (bloc) => bloc.add(LoadBatchesEvent()),
      skip: 1,
      expect: () => [
        BatchState.initial().copyWith(isLoading: false, batches: lstBatches),
      ],
      verify: (_) {
        verify(() => getAllBatchUseCase.call()).called(1);
      },
    );
    blocTest<BatchViewModel, BatchState>(
      'emits [BatchState] with error when LoadBatches fails',
      build: () {
        when(() => getAllBatchUseCase.call()).thenAnswer(
          (_) async => Left(RemoteDatabaseFailure(message: 'Error')),
        );
        return batchViewModel;
      },
      act: (bloc) => bloc.add(LoadBatchesEvent()),
      expect: () => [
        BatchState.initial().copyWith(isLoading: true),
        BatchState.initial().copyWith(isLoading: false, errorMessage: 'Error'),
      ],
      verify: (_) {
        verify(() => getAllBatchUseCase.call()).called(1);
      },
    );
  });

  tearDown(() {
    batchViewModel.close();
  });
}
