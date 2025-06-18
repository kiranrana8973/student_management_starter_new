import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

abstract interface class IBatchDataSource {
  Future<void> addBatch(BatchEntity batch);
  Future<List<BatchEntity>> getBatches();
  Future<void> deleteBatch(String batchId,String? token);
}
