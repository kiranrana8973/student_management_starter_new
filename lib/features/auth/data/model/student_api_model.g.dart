// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentApiModel _$StudentApiModelFromJson(Map<String, dynamic> json) =>
    StudentApiModel(
      studentId: json['_id'] as String?,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String,
      batch: BatchApiModel.fromJson(json['batch'] as Map<String, dynamic>),
      course: (json['courses'] as List<dynamic>)
          .map((e) => CourseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      username: json['username'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$StudentApiModelToJson(StudentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.studentId,
      'fname': instance.fname,
      'lname': instance.lname,
      'image': instance.image,
      'phone': instance.phone,
      'batch': instance.batch.batchId,
      'course': instance.course.map((e) => e.courseId).toList(),
      'username': instance.username,
      'password': instance.password,
    };
