import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/auth/presentation/view/register_view.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_state.dart';
import 'package:student_management/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:student_management/features/home/presentation/view_model/home_view_model.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  LoginViewModel() : super(LoginState.initial()) {
    on<NavigateToRegisterView>(_onNavigateToRegisterView);
    on<NavigateToHomeView>(_onNavigateToHomeView);
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterView event,
    Emitter<LoginState> emit,
  ) {
    // Logic to navigate to Register View
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterViewModel(),
            child: event.destination,
          ),
        ),
      );
    }
  }

  void _onNavigateToHomeView(
    NavigateToHomeView event,
    Emitter<LoginState> emit,
  ) {
    // Logic to navigate to Home View
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [BlocProvider(create: (context) => HomeViewModel())],
            child: event.destination,
          ),
        ),
      );
    }
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPassword event,
    Emitter<LoginState> emit,
  ) {}
}
