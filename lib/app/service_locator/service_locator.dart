import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:student_management/core/network/api_service.dart';
import 'package:student_management/core/network/hive_service.dart';
import 'package:student_management/features/auth/data/data_source/local_datasource/student_local_datasource.dart';
import 'package:student_management/features/auth/data/repository/local_repository/student_local_repository.dart';
import 'package:student_management/features/auth/domain/use_case/student_get_current_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/student_image_upload_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/student_login_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/student_register_usecase.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/data/data_source/local_datasource/batch_local_datasource.dart';
import 'package:student_management/features/batch/data/data_source/remote_datasource/batch_remote_datasource.dart';
import 'package:student_management/features/batch/data/repository/local_repository/batch_local_repository.dart';
import 'package:student_management/features/batch/data/repository/remote_repository/batch_remote_repository.dart';
import 'package:student_management/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:student_management/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:student_management/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:student_management/features/course/data/repository/local_repository/course_local_repository.dart';
import 'package:student_management/features/course/data/repository/remote_repository/course_remote_repository.dart';
import 'package:student_management/features/course/domain/use_case/create_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:student_management/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';
import 'package:student_management/features/home/presentation/view_model/home_view_model.dart';
import 'package:student_management/features/splash/presentation/view_model/splash_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await initApiModule();
  // Initialize all modules
  await _initCourseModule();
  await _initBatchModule();
  await _initAuthModule();
  await _initHomeModule();
  await _initSplashModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> initApiModule() async {
  // Dio instance
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));
}

Future<void> _initCourseModule() async {
  // Data Source
  serviceLocator.registerFactory(
    () => CourseRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );
  serviceLocator.registerFactory<CourseLocalDataSource>(
    () => CourseLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );

  // Repository
  serviceLocator.registerFactory<CourseRemoteRepository>(
    () => CourseRemoteRepository(
      courseRemoteDataSource: serviceLocator<CourseRemoteDataSource>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CourseLocalRepository(
      courseLocalDataSource: serviceLocator<CourseLocalDataSource>(),
    ),
  );

  // Usecase
  serviceLocator.registerFactory(
    () => GetAllCourseUsecase(
      courseRepository: serviceLocator<CourseRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => CreateCourseUsecase(
      courseRepository: serviceLocator<CourseRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => DeleteCourseUsecase(
      courseRepository: serviceLocator<CourseRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => CourseViewModel(
      getAllCourseUsecase: serviceLocator<GetAllCourseUsecase>(),
      createCourseUsecase: serviceLocator<CreateCourseUsecase>(),
      deleteCourseUsecase: serviceLocator<DeleteCourseUsecase>(),
    ),
  );
}

Future<void> _initBatchModule() async {
  // Data Source
  serviceLocator.registerFactory(
    () => BatchLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );
  serviceLocator.registerFactory(
    () => BatchRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Repository
  serviceLocator.registerFactory<BatchLocalRepository>(
    () => BatchLocalRepository(
      batchLocalDatasource: serviceLocator<BatchLocalDatasource>(),
    ),
  );

  serviceLocator.registerFactory<BatchRemoteRepository>(
    () => BatchRemoteRepository(
      batchRemoteDatasource: serviceLocator<BatchRemoteDatasource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllBatchUsecase(
      batchRepository: serviceLocator<BatchRemoteRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CreateBatchUsecase(
      batchRepository: serviceLocator<BatchRemoteRepository>(),
    ),
  );
  serviceLocator.registerFactory(
    () => DeleteBatchUsecase(
      batchRepository: serviceLocator<BatchRemoteRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BatchViewModel(
      getAllBatchUsecase: serviceLocator<GetAllBatchUsecase>(),
      createBatchUsecase: serviceLocator<CreateBatchUsecase>(),
      deleteBatchUsecase: serviceLocator<DeleteBatchUsecase>(),
    ),
  );
}

Future<void> _initAuthModule() async {
  serviceLocator.registerFactory(
    () => StudentLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory(
    () => StudentLocalRepository(
      studentLocalDatasource: serviceLocator<StudentLocalDatasource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => StudentLoginUsecase(
      studentRepository: serviceLocator<StudentLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => StudentRegisterUsecase(
      studentRepository: serviceLocator<StudentLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadImageUsecase(
      studentRepository: serviceLocator<StudentLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => StudentGetCurrentUsecase(
      studentRepository: serviceLocator<StudentLocalRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => RegisterViewModel(
      serviceLocator<BatchViewModel>(),
      serviceLocator<CourseViewModel>(),
      serviceLocator<StudentRegisterUsecase>(),
      serviceLocator<UploadImageUsecase>(),
    ),
  );

  // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<StudentLoginUsecase>()),
  );
}

Future<void> _initHomeModule() async {
  serviceLocator.registerFactory(
    () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
  );
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashViewModel());
}
