import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:student_management/features/auth/presentation/view/register_view.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/domain/entity/course_entity.dart';
import 'package:student_management/features/course/presentation/view_model/course_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_state.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';

import '../test_data/batch_test_data.dart';
import '../test_data/course_test_data.dart';

class MockBatchBloc extends MockBloc<BatchEvent, BatchState>
    implements BatchViewModel {}

class MockCourseBloc extends MockBloc<CourseEvent, CourseState>
    implements CourseViewModel {}

class MockRegisterBloc extends MockBloc<RegisterEvent, RegisterState>
    implements RegisterViewModel {}

void main() {
  late MockBatchBloc batchBloc;
  late MockCourseBloc courseBloc;
  late MockRegisterBloc registerBloc;

  setUp(() {
    batchBloc = MockBatchBloc();
    courseBloc = MockCourseBloc();
    registerBloc = MockRegisterBloc();
  });

  Widget loadRegisterView(Widget body) {
    when(() => batchBloc.state).thenReturn(
      BatchState(
        isLoading: false,
        errorMessage: '',
        batches: BatchTestData.getBatchTestData(),
      ),
    );
    // Load CourseTestData
    when(() => courseBloc.state).thenReturn(
      CourseState(
        isLoading: false,
        errorMessage: '',
        courses: CourseTestData.getCourseTestData(),
      ),
    );
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<BatchViewModel>.value(value: batchBloc),
          BlocProvider<CourseViewModel>.value(value: courseBloc),
          BlocProvider<RegisterViewModel>.value(value: registerBloc),
        ],
        child: RegisterView(),
      ),
    );
  }

  testWidgets('Check for the title "Register Student"', (tester) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    expect(find.text('Register'), findsOneWidget);
  });

  // Check for the Dropdown data
  testWidgets('Load Dropdown value and select Second index data', (
    tester,
  ) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    final dropdownFinder = find.byType(DropdownButtonFormField<BatchEntity>);
    await tester.ensureVisible(dropdownFinder);

    await tester.tap(dropdownFinder);

    // Use this because the menu items are not visible
    await tester.pumpAndSettle();

    //tap on the first item in the dropdown
    await tester.tap(find.byType(DropdownMenuItem<BatchEntity>).at(1));
    //Use this to close the dropdown
    await tester.pumpAndSettle();

    expect(find.text('30-B'), findsOneWidget);
  });

  // Check for the MultiSelect Dialog field
  testWidgets('Load MultiSelect Dialog and select Flutter and Api', (
    tester,
  ) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();
    final multiSelectFinder = find.byType(MultiSelectDialogField<CourseEntity>);
    await tester.ensureVisible(multiSelectFinder);

    await tester.tap(multiSelectFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Flutter'));
    await tester.tap(find.text('Api'));

    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    expect(find.text('Flutter'), findsOneWidget);
  });

  // Test all the fields
  testWidgets('test al lthe fields', (tester) async {
    await tester.pumpWidget(loadRegisterView(RegisterView()));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Kiran');
    await tester.enterText(find.byType(TextFormField).at(1), 'Rana');
    await tester.enterText(find.byType(TextFormField).at(2), '9844332211');
    await tester.enterText(find.byType(TextFormField).at(3), 'kiran');
    await tester.enterText(find.byType(TextFormField).at(4), 'kiran123');

    //=========================== Find the dropdownformfield===========================

    final dropdownFinder = find.byType(DropdownButtonFormField<BatchEntity>);

    when(
      () => registerBloc.state,
    ).thenReturn(RegisterState(isLoading: false, isSuccess: true));

    await tester.ensureVisible(dropdownFinder);

    await tester.tap(dropdownFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownMenuItem<BatchEntity>).at(0));

    await tester.pumpAndSettle();

    //=========================== Find the MultiSelectDialogField===========================
    final multiSelectFinder = find.byType(MultiSelectDialogField<CourseEntity>);
    await tester.ensureVisible(multiSelectFinder);

    await tester.tap(multiSelectFinder);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Flutter'));
    await tester.tap(find.text('Api'));

    await tester.tap(find.text('OK'));

    await tester.pumpAndSettle();

    //=========================== Find the register button===========================
    final registerButtonFinder = find.widgetWithText(
      ElevatedButton,
      'Register',
    );

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.text('Kiran'), findsOneWidget);
    expect(find.text('Rana'), findsOneWidget);
    expect(find.text('9844332211'), findsOneWidget);
    expect(find.text('kiran'), findsOneWidget);
    expect(find.text('kiran123'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(registerBloc.state.isSuccess, true);
  });
}
