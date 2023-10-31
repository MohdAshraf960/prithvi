import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:logger/logger.dart';

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
      Logger().e("CODE ==> ${e.code}  MESSAGE ===> ${e.message}");

      switch (e.code) {
        case "user-not-found":
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case "wrong-password":
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case "user-disabled":
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case "invalid-email":
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case "email-already-in-use":
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'weak-password':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'operation-not-allowed':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'auth/user-not-found':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'auth/invalid-email':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'account-exists-with-different-credential':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'invalid-credential':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'invalid-verification-code':
          RoutePage.showErrorSnackbars(e.message!);
          break;
        case 'invalid-verification-id':
          RoutePage.showErrorSnackbars(e.message!);
          break;

        case 'INVALID_LOGIN_CREDENTIALS':
          RoutePage.showErrorSnackbars("Email or password may be invalid");
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          RoutePage.showErrorSnackbars("Anonymous accounts are not enabled");
          break;
        case "ERROR_WEAK_PASSWORD":
          RoutePage.showErrorSnackbars("Your password is too weak");
          break;
        case "ERROR_INVALID_EMAIL":
          RoutePage.showErrorSnackbars("Your email is invalid");
          break;
        case "ERROR_EMAIL_ALREADY_IN_USE":
          RoutePage.showErrorSnackbars(
              "Email is already in use on different account");
          break;
        case "ERROR_INVALID_CREDENTIAL":
          RoutePage.showErrorSnackbars("Your email is invalid");
          break;
        case '17999':
          RoutePage.showErrorSnackbars("Email or password may be invalid");
          break;
        default:
          RoutePage.showErrorSnackbars(e.message!);
      }

      return;
    }
    if (e is AppException) {
      Logger().e("AppException ==>  ${e.message}");
      RoutePage.showErrorSnackbars("${e.message}");
      return;
    }
    if (e is SocketException) {
      Logger().e("SocketException ==> ${e.message}");
      RoutePage.showErrorSnackbars(e.message);
      return;
    }
    if (e is FormatException) {
      Logger().e("FormatException ==> ${e.message}");
      RoutePage.showErrorSnackbars(e.message);
      return;
    }
    if (e is TimeoutException) {
      Logger().e("TimeoutException ==> ${e.message}");
      RoutePage.showErrorSnackbars("Oops!!! request time out");
      return;
    }
    if (e is Exception) {
      Logger().e("Exception ==> ${e.toString()}");
      RoutePage.showErrorSnackbars("${e.toString()}");
      return;
    }
  }
}
