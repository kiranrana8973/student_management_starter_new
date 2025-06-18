import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/batch/data/data_source/batch_datasource.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';

class BatchLocalDatasource implements IBatchDataSource {
  final HiveService hiveService;

  BatchLocalDatasource({required this.hiveService});

  @override
  Future<void> addBatch(BatchEntity batch) async {
    try {
      await hiveService.addBatch(BatchHiveModel.fromEntity(batch));
    } catch (e) {
      throw Exception('Failed to add batch: $e');
    }
  }

  @override
  Future<void> deleteBatch(String batchId, String? token) async {
    try {
      await hiveService.deleteBatch(batchId);
    } catch (e) {
      throw Exception('Failed to delete batch: $e');
    }
  }

  @override
  Future<List<BatchEntity>> getBatches() async {
    try {
      final batches = await hiveService.getAllBatches();
      return BatchHiveModel.toEntityList(batches);
    } catch (e) {
      throw Exception('Failed to get batches: $e');
    }
  }
}
