import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

part 'course_api_model.g.dart';

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? courseId;
  final String courseName;

  const CourseApiModel({this.courseId, required this.courseName});

  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  // To entity

  // From Entity
  factory CourseApiModel.fromEntity(CourseEntity entity) {
    return CourseApiModel(
      courseId: entity.courseId,
      courseName: entity.courseName,
    );
  }

  // To Entity
  CourseEntity toEntity() {
    return CourseEntity(courseId: courseId, courseName: courseName);
  }

  // To Entity List
  static List<CourseEntity> toEntityList(List<CourseApiModel> entityList) {
    return entityList.map((data) => data.toEntity()).toList();
  }

  // From entity list
  static List<CourseApiModel> fromEntityList(List<CourseEntity> entityList) {
    return entityList
        .map((entity) => CourseApiModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
