import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_management/app/constant/hive_table_constant.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:uuid/uuid.dart';

part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String courseId;
  @HiveField(1)
  final String courseName;

  CourseHiveModel({String? courseId, required this.courseName})
    : courseId = courseId ?? const Uuid().v4();

  const CourseHiveModel.initial() : courseId = '', courseName = '';

  // from course entity
  factory CourseHiveModel.fromEntity(CourseEntity course) {
    return CourseHiveModel(
      courseId: course.courseId,
      courseName: course.courseName,
    );
  }

  // to course entity
  CourseEntity toEntity() {
    return CourseEntity(courseId: courseId, courseName: courseName);
  }

  // convert list of CourseHiveModel to list of CourseEntity
  static List<CourseEntity> toEntityList(List<CourseHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  List<Object?> get props => [courseId, courseName];
}
