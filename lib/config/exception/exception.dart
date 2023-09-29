import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prithvi/core/routes/routes.dart';

class AppException implements Exception {
  final String? message;
  final int? code;
  AppException({this.message, this.code});
  @override
  String toString() {
    if (message != null) {
      return "$code $message";
    } else {
      return "Sometimes went wrong";
    }
  }

  static void onError(Object e) {
    if (e is FirebaseAuthException) {
      RoutePage.showErrorSnackbars(e.message!);
    }
    if (e is AppException) {
      debugPrint("AppException ==> ${e.code} ${e.message}");
      RoutePage.showErrorSnackbars("${e.message}");
      return;
    }
    if (e is SocketException) {
      debugPrint("SocketException ==> ${e.message}");
      RoutePage.showErrorSnackbars(e.message);
      return;
    }
    if (e is FormatException) {
      debugPrint("FormatException ==> ${e.message}");
      RoutePage.showErrorSnackbars(e.message);
      return;
    }
    if (e is TimeoutException) {
      debugPrint("TimeoutException ==> ${e.message}");
      RoutePage.showErrorSnackbars("Oops!!! request time out");
      return;
    }
    if (e is Exception) {
      debugPrint("Exception ==> ${e.toString()}");
      RoutePage.showErrorSnackbars("${e.toString()}");
      return;
    }
  }
}
