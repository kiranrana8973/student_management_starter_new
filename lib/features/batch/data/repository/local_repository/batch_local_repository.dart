import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class BatchLocalRepository implements IBatchRepository {
  final BatchLocalDatasource batchLocalDatasource;

  BatchLocalRepository({required this.batchLocalDatasource});

  @override
  Future<Either<Failure, void>> addBatch(BatchEntity batch) async {
    try {
      await batchLocalDatasource.addBatch(batch);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to add batch'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(
    String batchId,
    String? token,
  ) async {
    try {
      await batchLocalDatasource.deleteBatch(batchId, token);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to delete batch'));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final batches = await batchLocalDatasource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: 'Failed to get batches'));
    }
  }
}
