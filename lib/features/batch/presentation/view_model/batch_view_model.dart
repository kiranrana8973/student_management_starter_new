import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';

class BatchViewModel extends Bloc<BatchEvent, BatchState> {
  final GetAllBatchUsecase getAllBatchUsecase;
  final CreateBatchUsecase createBatchUsecase;
  final DeleteBatchUsecase deleteBatchUsecase;

  BatchViewModel({
    required this.getAllBatchUsecase,
    required this.createBatchUsecase,
    required this.deleteBatchUsecase,
  }) : super(const BatchState.initial()) {
    on<LoadBatchesEvent>(_onLoadBatches);
    on<CreateBatchEvent>(_onCreateBatch);
    on<DeleteBatchEvent>(_onDeleteBatch);

    // Load batches when the ViewModel is initialized
    add(LoadBatchesEvent());
  }

  Future<void> _onLoadBatches(
    LoadBatchesEvent event,
    Emitter<BatchState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await getAllBatchUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (batches) {
        emit(state.copyWith(batches: batches, isLoading: false));
      },
    );
  }

  Future<void> _onCreateBatch(
    CreateBatchEvent event,
    Emitter<BatchState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await createBatchUsecase(
      CreateBatchParams(batchName: event.batchName),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (_) {
        emit(state.copyWith(isLoading: false));
        add(LoadBatchesEvent());
      },
    );
  }

  Future<void> _onDeleteBatch(
    DeleteBatchEvent event,
    Emitter<BatchState> emit,
  ) async {
    // Logic to delete a batch
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 1));
    final result = await deleteBatchUsecase.call(
      DeleteBatchParams(batchId: event.batchId),
    );
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (_) {
        emit(state.copyWith(isLoading: false));
        add(LoadBatchesEvent());
      },
    );
  }
}
