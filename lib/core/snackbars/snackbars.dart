import 'package:flutter/material.dart';

extension SnackBarExt on BuildContext {
  void snackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.black,
          content: Text(message, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void errorSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text(message, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void successSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.green,
          content: Text(message, overflow: TextOverflow.ellipsis),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
