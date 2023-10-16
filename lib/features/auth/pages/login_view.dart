import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/pages/forgot_password_view.dart';
import 'package:prithvi/features/auth/pages/pages.dart';

import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/features/dashboard/widgets/bottombar.dart';
import 'package:prithvi/features/features.dart';

import 'package:prithvi/models/model.dart';

import 'package:sizer/sizer.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  static const id = "/login";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isObscure = true;
  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final media = MediaQuery.of(context);
    final signInNotifier = ref.watch(signInStateNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            height: size.height * 1,
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(gradient: primaryGreenGradient),
            child: Lottie.network(
              "https://firebasestorage.googleapis.com/v0/b/prithvi-70646.appspot.com/o/lottie%2Frotate_earth.json?alt=media&token=d6c82e03-35b9-4c92-8e18-aa49bcd89eb3&_gl=1*1h7zjfk*_ga*MTcyMDYzOTI3Mi4xNjgzNzg3Nzc0*_ga_CW55HF8NVT*MTY5NzQ2Mzg1NS4xMTIuMC4xNjk3NDYzODU1LjYwLjAuMA..",
              width: size.width * 0.9,
            ),
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
                  height: size.height * 0.52, // Set to 50% of screen height
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
                                        obscureText: isObscure,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        labelText: "Enter Password",
                                        fontSize: 12.sp,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(right: 16),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                isObscure = !isObscure;
                                              });
                                            },
                                            child: Icon(
                                              isObscure
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: grey3Color,
                                            ),
                                          ),
                                        ),
                                        // controller: viewModel.password,
                                        fontWeight: FontWeight.w400),

                                    // ... rest of your form fields

                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            ForgotPassword.id,
                                          );
                                        },
                                        child: Text(
                                          "Forgot Password",
                                          style: TextStyle(color: primaryGreen),
                                        ),
                                      ),
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
                                                //   handleLogin();
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
                                            context,
                                            SignUp.id,
                                          );
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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => BottomBar(),
            ),
            (route) => false,
          );
          // if (result.isVerified) {
          //   Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //       builder: (_) => BottomBar(),
          //     ),
          //     (route) => false,
          //   );
          // } else {
          //   AppException.onError(
          //     AppException(message: "User Is not verified"),
          //   );
          // }
        },
        onError: (error) {
          AppException.onError(error);
        });
  }
}
