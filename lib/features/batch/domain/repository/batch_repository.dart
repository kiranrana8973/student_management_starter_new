import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchRepository {
  Future<Either<Failure, void>> addBatch(BatchEntity batch);
  Future<Either<Failure, List<BatchEntity>>> getBatches();
  Future<Either<Failure, void>> deleteBatch(String batchId);
}
