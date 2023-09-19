import 'package:flutter/material.dart';
import 'package:prithvi/config/exception/exception.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/auth_service.dart';

class SignUpNotifier extends ChangeNotifier {
  final AuthService _authService;

  SignUpNotifier({required AuthService authService})
      : _authService = authService;

  userSignUp(SignUpModel signUpModel) async {
    try {
      final result = await _authService.signUpUser(signUpModel);
      if (result) {
        //TODO: navigate to Login screen
      }
    } catch (e) {
      AppException.onError(e);
    }
  }
}
