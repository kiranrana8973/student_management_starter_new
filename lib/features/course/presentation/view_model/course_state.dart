import 'package:equatable/equatable.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';

class CourseState extends Equatable {
  final bool isLoading;
  final List<CourseEntity> courses;
  final String? errorMessage;

  const CourseState({
    required this.isLoading,
    required this.courses,
    this.errorMessage,
  });

  factory CourseState.initial() {
    return CourseState(isLoading: false, courses: [], errorMessage: '');
  }

  CourseState copyWith({
    bool? isLoading,
    List<CourseEntity>? courses,
    String? errorMessage,
  }) {
    return CourseState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, courses, errorMessage];
}
