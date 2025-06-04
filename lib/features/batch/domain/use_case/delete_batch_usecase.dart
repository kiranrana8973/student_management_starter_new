import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
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

  DeleteBatchUsecase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(DeleteBatchParams params) async {
    return await batchRepository.deleteBatch(params.batchId);
  }
}
