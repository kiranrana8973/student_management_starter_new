import 'package:flutter/material.dart';

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
              ElevatedButton(onPressed: () {}, child: Text('Add Course')),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
