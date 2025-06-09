import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_management/app/constant/hive_table_constant.dart';
import 'package:student_management/features/auth/data/model/student_hive_model.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/course/data/model/course_hive_model.dart';

class HiveService {
  Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}student_management.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(CourseHiveModelAdapter());
    Hive.registerAdapter(BatchHiveModelAdapter());
    Hive.registerAdapter(StudentHiveModelAdapter());

    // Add Dummy Data
    await addBatchData();
    await addCourseData();  }

  // Add Dummy data for batch and course
  Future<void> addBatchData() async {
    final batch1 = BatchHiveModel(batchName: '34-A');
    final batch2 = BatchHiveModel(batchName: '34-B');
    final batch3 = BatchHiveModel(batchName: '34-C');

    await addBatch(batch1);
    await addBatch(batch2);
    await addBatch(batch3);
  }

  Future<void> addCourseData() async {
    final course1 = CourseHiveModel(courseName: 'Flutter');
    final course2 = CourseHiveModel(courseName: 'Dart');
    final course3 = CourseHiveModel(courseName: 'Java');

    await addCourse(course1);
    await addCourse(course2);
    await addCourse(course3);
  }

  // Batch Queries
  Future<void> addBatch(BatchHiveModel batch) async {
    // Check if the batch already exists
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);

    await box.put(batch.batchId, batch);
  }

  Future<void> deleteBatch(String id) async {
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    await box.delete(id);
  }

  Future<List<BatchHiveModel>> getAllBatches() async {
    // Sort by BatchName
    var box = await Hive.openBox<BatchHiveModel>(HiveTableConstant.batchBox);
    return box.values.toList()
      ..sort((a, b) => a.batchName.compareTo(b.batchName));
  }

  // Course Queries
  Future<void> addCourse(CourseHiveModel course) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);

    await box.put(course.courseId, course);
  }

  Future<void> deleteCourse(String id) async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    await box.delete(id);
  }

  Future<List<CourseHiveModel>> getAllCourses() async {
    var box = await Hive.openBox<CourseHiveModel>(HiveTableConstant.courseBox);
    return box.values.toList();
  }

  // Auth Queries
  Future<void> register(StudentHiveModel auth) async {
    var box = await Hive.openBox<StudentHiveModel>(
      HiveTableConstant.studentBox,
    );
    await box.put(auth.studentId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<StudentHiveModel>(
      HiveTableConstant.studentBox,
    );
    await box.delete(id);
  }

  Future<List<StudentHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<StudentHiveModel>(
      HiveTableConstant.studentBox,
    );
    return box.values.toList();
  }

  // Login using username and password
  Future<StudentHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<StudentHiveModel>(
      HiveTableConstant.studentBox,
    );
    var student = box.values.firstWhere(
      (element) => element.username == username && element.password == password,
      orElse: () => throw Exception('Invalid username or password'),
    );
    box.close();
    return student;
  }

  // Clear all data and delete database
  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(HiveTableConstant.batchBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.courseBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.studentBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
