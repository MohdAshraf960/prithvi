import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';

import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/features/dashboard/widgets/bottombar.dart';
import 'package:prithvi/features/features.dart';

import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/locator.dart';

import 'package:sizer/sizer.dart';

import '../../../services/firebase_analytics.dart';

class Login extends ConsumerWidget {
  static const id = "/login";
  Login({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> handleLogin() async {
    final email = _emailController.text;

    try {
      print("ttttttttttttttttttttttttttttttttttttttttttttttt");
      // Perform your login logic here

      // If login is successful, log the "login" event
      await locator<AnalyticsServices>().logLoginEvent(email);

      // Navigate to the home screen or perform other actions
    } catch (error) {
      print("catch");

      // Handle login error
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final media = MediaQuery.of(context);
    final signInNotifier = ref.watch(signInStateNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(gradient: primaryGreenGradient),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Spacer(
                  flex: media.viewInsets.bottom == 0
                      ? size.height > 800
                          ? 3
                          : 3
                      : 1,
                ),
                Container(
                  // Wrap the BackdropFilter with a Container
                  height: size.height * 0.54, // Set to 50% of screen height
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      width: size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                ),
                                color: Colors.white,
                                // borderRadius: BorderRadius.circular(8),
                              ),
                              width: size.width,
                              padding: EdgeInsets.only(
                                top: size.height * 0.016,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(
                                    //   height: 2.h,
                                    // ),
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: primaryGreen,
                                          fontSize: 24),
                                    ),
                                    SizedBox(
                                      height: 0.2.h,
                                    ),
                                    Text(
                                      "to your account ✨",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: grey2Color,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.5,
                                    ),

                                    AppFormField(
                                        validator: (value) =>
                                            Validator.requiredValidator(value),
                                        inputType: TextInputType.emailAddress,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        // hintText: "Enter Email",
                                        // hintfontSize: 12.sp,
                                        labelText: "Enter Email",
                                        controller: _emailController,
                                        fontSize: 12.sp,
                                        // controller: viewModel.email,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.6,
                                    ),
                                    AppFormField(
                                        controller: _passwordController,
                                        validator: (value) =>
                                            Validator.requiredValidator(value),
                                        inputType: TextInputType.text,
                                        obscureText: true,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        labelText: "Enter Password",
                                        fontSize: 12.sp,
                                        suffixIcon: const Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child: Icon(
                                            Icons.remove_red_eye,
                                            color: grey3Color,
                                          ),
                                        ),
                                        // controller: viewModel.password,
                                        fontWeight: FontWeight.w400),

                                    // ... rest of your form fields

                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Forgot Password",
                                            style:
                                                TextStyle(color: primaryGreen),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.1,
                                    ),
                                    signInNotifier.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : CustomButton(
                                            textfontsize: 16,
                                            height: 6.h,
                                            textColor: whiteColor,
                                            color: primaryGreen,
                                            text: "LOGIN",
                                            onTap: () async {
                                              formKey.currentState!.save();
                                              if (formKey.currentState!
                                                  .validate()) {
                                                _userSignIn(
                                                    signInNotifier, context);
                                                handleLogin();
                                              }
                                            },
                                            width: double.infinity,
                                          ),
                                    SizedBox(height: 16),
                                    Container(
                                      height: 6.h,
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, "/signup");
                                        },
                                        child: Text(
                                          'Signup'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.black, // Text color
                                          ),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                12.0), // Border radius
                                          ),
                                          side: BorderSide(
                                            color: Colors.grey, // Border color
                                            width: 0.5, // Border width
                                          ),
                                        ),
                                      ),
                                    ),
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.pushNamed(context, SignUp.id);
                                    //   },
                                    //   child: Text(
                                    //     "Do you want to Sign Up?",
                                    //     style: TextStyle(
                                    //         color: grey2Color, fontSize: 12),
                                    //   ),
                                    // ),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.9,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _userSignIn(SignInNotifier signInNotifier, context) {
    signInNotifier.userSignIn(
        userSignInModel: SignInModel(
          email: _emailController.text,
          password: _passwordController.text,
        ),
        onSuccess: (result) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BottomBar(),
            ),
          );
          // RoutePage.navigatorKey.currentState!
          //     .pushNamedAndRemoveUntil(Home.id, (route) => false);
        },
        onError: (error) {
          AppException.onError(error);
        });
  }
}
