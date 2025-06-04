import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management/app/constant/hive_table_constant.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';

class HiveService {
  Future<void> initHive() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/student_management.db';

    Hive.init(path);

    Hive.registerAdapter(BatchHiveModelAdapter());
  }

  // ========================== Batch Queries ==========================
  Future<void> addBatch(BatchHiveModel batch) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.put(batch.batchId, batch);
    await box.close();
  }

  Future<List<BatchHiveModel>> getBatches() async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    List<BatchHiveModel> batches = box.values.toList();
    await box.close();
    return batches;
  }

  Future<void> deleteBatch(String batchId) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(batchId);
    await box.close();
  }
}
