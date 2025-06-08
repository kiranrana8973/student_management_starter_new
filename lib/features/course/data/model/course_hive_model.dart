import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:student_management/app/constant/hive_table_constant.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

import 'package:uuid/uuid.dart';

part 'course_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.courseTableId)
class CourseHiveModel extends Equatable {
  @HiveField(0)
  final String? courseId;

  @HiveField(1)
  final String courseName;

  CourseHiveModel({String? courseId, required this.courseName})
    : courseId = courseId ?? const Uuid().v4();

  // Initial Constructor
  const CourseHiveModel.initial() : courseId = '', courseName = '';

  // From Entity
  factory CourseHiveModel.fromEntity(CourseEntity entity) {
    return CourseHiveModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

  // To Entity
  CourseEntity toEntity() {
    return CourseEntity(courseId: courseId, courseName: courseName);
  }

  // To Entity List : From database to Entity List
  static List<CourseEntity> toEntityList(List<CourseHiveModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // from Entity List : From Entity List to Database
  static List<CourseHiveModel> fromEntityList(List<CourseEntity> entityList) {
    return entityList.map((data) => CourseHiveModel.fromEntity(data)).toList();
  }

  @override
  List<Object?> get props => [courseId, courseName];
}
