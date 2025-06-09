import 'package:flutter/cupertino.dart';
import 'package:student_management/app/app.dart';
import 'package:student_management/app/service_locator/service_locator.dart';
import 'package:student_management/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  // init Hive service
  await HiveService().init();

  // Delete database
  // await HiveService().clearAll();

  runApp(App());
}
