import 'package:equatable/equatable.dart';

sealed class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class LoadCourseEvent extends CourseEvent {}

class CreateCourseEvent extends CourseEvent {
  final String courseName;

  const CreateCourseEvent({required this.courseName});

  @override
  List<Object> get props => [courseName];
}

class DeleteCourseEvent extends CourseEvent {
  final String courseId;

  const DeleteCourseEvent({required this.courseId});

  @override
  List<Object> get props => [courseId];
}
