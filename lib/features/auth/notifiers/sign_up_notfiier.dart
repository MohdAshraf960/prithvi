import 'package:flutter/material.dart';
import 'package:prithvi/services/auth_service.dart';

class SignUpNotifier extends ChangeNotifier {
  final AuthService _authService;

  SignUpNotifier({required AuthService authService})
      : _authService = authService;
}
