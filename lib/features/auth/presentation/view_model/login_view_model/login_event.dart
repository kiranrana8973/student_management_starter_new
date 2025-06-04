import 'package:flutter/material.dart';

@immutable
sealed class LoginEvent {}

class NavigateToRegisterView extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  NavigateToRegisterView({required this.context, required this.destination});
}

class NavigateToHomeView extends LoginEvent {
  final BuildContext context;
  final Widget destination;

  NavigateToHomeView({required this.context, required this.destination});
}

class LoginWithEmailAndPassword extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  LoginWithEmailAndPassword({
    required this.context,
    required this.email,
    required this.password,
  });
}
