import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:student_management/app/use_case/usecase.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class CreateBatchParams extends Equatable {
  final String batchName;

  const CreateBatchParams({required this.batchName});

  // empty constructor for initial state
  const CreateBatchParams.initial() : batchName = '_empty.string';

  @override
  List<Object?> get props => [batchName];
}

class CreateBatchUsecase implements UsecaseWithParams<void, CreateBatchParams> {
  final IBatchRepository batchRepository;

  CreateBatchUsecase({required this.batchRepository});

  @override
  Future<Either<Failure, void>> call(CreateBatchParams params) async {
    return await batchRepository.addBatch(
      BatchEntity(batchName: params.batchName),
    );
  }
}
