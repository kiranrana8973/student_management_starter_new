import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/shared_pref/token_shared_prefs.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class DeleteBatchParams extends Equatable {
  final String batchId;

  const DeleteBatchParams({required this.batchId});

  const DeleteBatchParams.empty() : batchId = '_empty.string';

  @override
  List<Object?> get props => [batchId];
}

class DeleteBatchUsecase implements UsecaseWithParams<void, DeleteBatchParams> {
  final IBatchRepository batchRepository;
  final TokenSharedPrefs tokenSharedPrefs;

  DeleteBatchUsecase({
    required this.batchRepository,
    required this.tokenSharedPrefs,
  });

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) async {
    final token = await tokenSharedPrefs.getToken();
    return token.fold(
      (failure) => Left(failure),
      (token) async => await batchRepository.deleteBatch(params.batchId, token),
    );
  }
}
