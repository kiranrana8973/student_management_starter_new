import 'package:student_management/features/auth/domain/entity/student_entity.dart';

abstract interface class IStudentDataSource {
  Future<void> registerStudent(StudentEntity studentData);

  Future<String> loginStudent(String username, String password);

  Future<String> uploadProfilePicture(String filePath);

  Future<StudentEntity> getCurrentUser();
}
