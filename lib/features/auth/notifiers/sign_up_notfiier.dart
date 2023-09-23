import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

/// Notifier class for handling user sign-up.
class SignUpNotifier extends ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;

  SignUpNotifier({
    required AuthService authService,
  }) : _authService = authService;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Sign up a user with the provided [signUpModel].
  ///
  /// Calls [onSuccess] when sign-up is successful and [onError] in case of errors.
  ///
  /// If an exception occurs, it is caught and passed to [onError], along with
  /// an optional error message if available.
  void userSignUp({
    required SignUpModel userSignUpModel,
    required Function(SignUpResult result) onSuccess,
    required Function(Object e) onError,
  }) async {
    try {
      isLoading = true;
      final signUpResult = await _authService.signUpUser(userSignUpModel);
      if (signUpResult.success) {
        // If signup was successful, call the onSuccess callback
        onSuccess(signUpResult);
      } else {
        // If signup failed, call the onError callback with the error message
        onError(signUpResult.errorMessage ?? 'An error occurred');
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      // If an exception occurred, call the onError callback with the exception
      onError(e);
      // Optionally, log the error for debugging purposes
      log('Error during sign-up: $e');
    }
  }
}
