// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/features/auth/pages/signup_view.dart';
import 'package:prithvi/features/category/pages/category_view.dart';
import 'package:prithvi/features/home/pages/home_view.dart';
import 'package:prithvi/features/profile/pages/userprofile_view.dart';

class RoutePage {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Route<dynamic> getPage(RouteSettings routePage) {
    final args = routePage.arguments;

    return MaterialPageRoute(
      builder: (context) {
        switch (routePage.name) {
          case Login.id:
            return Login();

          case SignUp.id:
            return SignUp();

          case Home.id:
            return Home();

          case CategoryView.id:
            return CategoryView();

          case UserProfileScreen.id:
            return UserProfileScreen();

          default:
            return Login();
        }
      },
    );
  }

  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(SnackBar snackBar) {
    scaffoldMessengerKey.currentState?.hideCurrentMaterialBanner();
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

  static void showErrorSnackbars(String message) {
    showSnackbar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.roboto(color: Colors.white),
              ),
            ),
            const Icon(
              Icons.error,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  static void showSucessSnackbar(String message) {
    showSnackbar(SnackBar(
        backgroundColor: Colors.green,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const Icon(
              Icons.check,
              color: Colors.white,
            )
          ],
        )));
  }
}
