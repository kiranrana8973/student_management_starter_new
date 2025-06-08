import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/course/presentation/view_model/course_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';

class CourseView extends StatelessWidget {
  CourseView({super.key});

  final courseNameController = TextEditingController();
  final _courseViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _courseViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: courseNameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter course name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_courseViewFormKey.currentState!.validate()) {
                    context.read<CourseViewModel>().add(
                      CreateCourseEvent(
                        courseName: courseNameController.text.trim(),
                      ),
                    );
                  }
                },
                child: Text('Add Course'),
              ),
              SizedBox(height: 10),
              BlocBuilder<CourseViewModel, CourseState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage != null &&
                      state.errorMessage!.isNotEmpty) {
                    return Text('Error: ${state.errorMessage}');
                  }
                  if (state.courses.isEmpty) {
                    return Center(
                      child: Text(
                        'No courses available',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        return ListTile(
                          title: Text(course.courseName),
                          subtitle: Text(course.courseId ?? ''),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<CourseViewModel>().add(
                                DeleteCourseEvent(
                                  courseId: course.courseId ?? '',
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
