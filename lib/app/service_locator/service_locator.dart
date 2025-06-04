import 'package:get_it/get_it.dart';
import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:student_management/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management/features/batch/data/repository/local_repository/batch_local_repository.dart';
import 'package:student_management/features/batch/domain/repository/batch_repository.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';
import 'package:student_management/features/home/presentation/view_model/home_view_model.dart';
import 'package:student_management/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  await _initHiveService();
  // Initialize all modules
  await _initCourseModule();
  await _initBatchModule();
  await _initAuthModule();
  await _initHomeModule();
  await _initSplashModule();
}

Future _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future _initCourseModule() async {
  serviceLocator.registerFactory(() => CourseViewModel());
}

Future _initBatchModule() async {
  // Register Model
  serviceLocator.registerLazySingleton(() => BatchHiveModel.initial());
  // Register Data Source
  serviceLocator.registerLazySingleton(
    () => BatchLocalDatasource(
      hiveService: serviceLocator(),
      batchHiveModel: BatchHiveModel.initial(),
    ),
  );

  // Register Local Repository
  serviceLocator.registerLazySingleton<BatchLocalRepository>(
    () => BatchLocalRepository(batchLocalDatasource: serviceLocator()),
  );

  // Register use cases
  serviceLocator.registerLazySingleton(
    () => GetAllBatchUsecase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => CreateBatchUsecase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteBatchUsecase(
      batchRepository: serviceLocator<BatchLocalRepository>(),
    ),
  );
  // Register ViewModel
  serviceLocator.registerFactory(
    () => BatchViewModel(
      getAllBatchUsecase: serviceLocator(),
      createBatchUsecase: serviceLocator(),
      deleteBatchUsecase: serviceLocator(),
    ),
  );
}

Future _initHomeModule() async {
  serviceLocator.registerLazySingleton(
    () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
  );
}

Future _initAuthModule() async {
  serviceLocator.registerFactory(() => LoginViewModel());
  serviceLocator.registerFactory(() => RegisterViewModel());
}

Future _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}
