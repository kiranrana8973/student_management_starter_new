import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_management/features/auth/presentation/view/login_view.dart';
import 'package:student_management/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  // Open Login View after 2 seconds
  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => LoginViewModel(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }
}
