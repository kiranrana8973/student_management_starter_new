import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _gap = const SizedBox(height: 8);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'kiran');
  final _lnameController = TextEditingController(text: 'rana');
  final _phoneController = TextEditingController(text: '123456789');
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');

  BatchEntity? _dropDownValue;
  final List<CourseEntity> _lstCourseSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.grey[300],
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.camera),
                                label: const Text('Camera'),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.image),
                                label: const Text('Gallery'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircleAvatar(
                        radius: 50,
                        // backgroundImage: _img != null
                        //     ? FileImage(_img!)
                        //     : const AssetImage('assets/images/profile.png')
                        //         as ImageProvider,
                        backgroundImage:
                            const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                  ),
                  _gap,
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone No'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter phoneNo';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  BlocBuilder<BatchViewModel, BatchState>(
                    builder: (context, state) {
                      return DropdownButtonFormField<BatchEntity>(
                        items: state.batches
                            .map(
                              (e) => DropdownMenuItem<BatchEntity>(
                                value: e,
                                child: Text(e.batchName),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          _dropDownValue = value;
                        },
                        value: _dropDownValue,
                        decoration: const InputDecoration(
                          labelText: 'Select Batch',
                        ),
                        validator: ((value) {
                          if (value == null) {
                            return 'Please select batch';
                          }
                          return null;
                        }),
                      );
                    },
                  ),
                  _gap,
                  BlocBuilder<CourseViewModel, CourseState>(
                    builder: (context, courseState) {
                      if (courseState.isLoading) {
                        return const CircularProgressIndicator();
                      } else {
                        return MultiSelectDialogField(
                          title: const Text('Select course'),
                          items: courseState.courses
                              .map(
                                (course) =>
                                    MultiSelectItem(course, course.courseName),
                              )
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text(
                            'Select course',
                            style: TextStyle(color: Colors.black),
                          ),
                          buttonIcon: const Icon(Icons.search),
                          onConfirm: (values) {
                            _lstCourseSelected.clear();
                            _lstCourseSelected.addAll(values);
                          },
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black87),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select courses';
                            }
                            return null;
                          }),
                        );
                      }
                    },
                  ),
                  _gap,
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          context.read<RegisterViewModel>().add(
                            RegisterStudentEvent(
                              context: context,
                              fName: _fnameController.text,
                              lName: _lnameController.text,
                              phone: _phoneController.text,
                              batch: _dropDownValue!,
                              courses: _lstCourseSelected,
                              username: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
