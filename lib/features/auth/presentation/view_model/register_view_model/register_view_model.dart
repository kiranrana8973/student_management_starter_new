import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/core/common/snackbar/my_snackbar.dart';
import 'package:student_management/features/auth/domain/use_case/student_image_upload_usecase.dart';
import 'package:student_management/features/auth/domain/use_case/student_register_usecase.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_state.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_event.dart';
import 'package:student_management/features/batch/presentation/view_model/batch_view_model.dart';
import 'package:student_management/features/course/presentation/view_model/course_event.dart';
import 'package:student_management/features/course/presentation/view_model/course_view_model.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final BatchViewModel _batchViewModel;
  final CourseViewModel _courseViewModel;
  final StudentRegisterUsecase _studentRegisterUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  RegisterViewModel(
    this._batchViewModel,
    this._courseViewModel,
    this._studentRegisterUsecase,
    this._uploadImageUsecase,
  ) : super(RegisterState.initial()) {
    on<RegisterStudentEvent>(_onRegisterUser);
    on<UploadImageEvent>(_onLoadImage);
    on<LoadCoursesAndBatchesEvent>(_onLoadCoursesAndBatches);

    add(LoadCoursesAndBatchesEvent());
  }

  void _onLoadCoursesAndBatches(
    LoadCoursesAndBatchesEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isLoading: true));
    _batchViewModel.add(LoadBatchesEvent());
    _courseViewModel.add(LoadCourseEvent());
    emit(state.copyWith(isLoading: false, isSuccess: true));
  }

  Future<void> _onRegisterUser(
    RegisterStudentEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _studentRegisterUsecase(
      RegisterUserParams(
        fname: event.fName,
        lname: event.lName,
        phone: event.phone,
        batch: event.batch,
        courses: event.courses,
        username: event.username,
        password: event.password,
        image: state.imageName,
      ),
    );

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: l.message,
          color: Colors.red,
        );
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration Successful",
        );
      },
    );
  }

  void _onLoadImage(UploadImageEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(file: event.file),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
