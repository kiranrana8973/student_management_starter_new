import 'package:dartz/dartz.dart';
import 'package:student_management/core/error/failure.dart';
import 'package:student_management/features/batch/data/data_source/remote_datasource/batch_remote_datasource.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';

class BatchRemoteRepository implements IBatchRepository {
  final BatchRemoteDatasource _batchRemoteDatasource;

  BatchRemoteRepository({required BatchRemoteDatasource batchRemoteDatasource})
    : _batchRemoteDatasource = batchRemoteDatasource;

  @override
  Future<Either<Failure, void>> addBatch(BatchEntity batch) async {
    try {
      await _batchRemoteDatasource.addBatch(batch);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(
    String batchId,
    String? token,
  ) async {
    try {
      await _batchRemoteDatasource.deleteBatch(batchId, token);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final batches = await _batchRemoteDatasource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
}
