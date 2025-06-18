// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_courses_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCoursesDto _$GetAllCoursesDtoFromJson(Map<String, dynamic> json) =>
    GetAllCoursesDto(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCoursesDtoToJson(GetAllCoursesDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
