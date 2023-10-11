import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';

import 'package:prithvi/features/auth/widgets/textformfield.dart';

import 'package:sizer/sizer.dart';

class ForgotPassword extends ConsumerWidget {
  static const id = "/forgotpassword";
  ForgotPassword({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _forgotemailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final media = MediaQuery.of(context);

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
                  height: size.height * 0.34, // Set to 50% of screen height
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
                                      "Forgot Password",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: primaryGreen,
                                          fontSize: 24),
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
                                        controller: _forgotemailController,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.6,
                                    ),

                                    const SizedBox(
                                      height: kToolbarHeight * 0.1,
                                    ),

                                    CustomButton(
                                      textfontsize: 16,
                                      height: 6.h,
                                      textColor: whiteColor,
                                      color: primaryGreen,
                                      text: "Forgot Password".toUpperCase(),
                                      onTap: () async {
                                        formKey.currentState!.save();
                                        if (formKey.currentState!.validate()) {
                                          resetPassword(context);
                                        }
                                      },
                                      width: double.infinity,
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

  Future<void> resetPassword(context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => Center(
          child: CustomLoader(),
        ),
      );
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _forgotemailController.text.trim());
      RoutePage.showSucessSnackbar("Please check you email for reset password");
      Navigator.pushNamed(context, LoginView.id);
    } on FirebaseAuthException catch (e) {
      print(e);
      AppException.onError(e);
      Navigator.pop(context);
    }
  }

  // _userSignIn(SignInNotifier signInNotifier, context) {
  //   signInNotifier.userSignIn(
  //       userSignInModel: SignInModel(
  //         email: _emailController.text,
  //         password: _passwordController.text,
  //       ),
  //       onSuccess: (result) {
  //         Navigator.of(context).push(
  //           MaterialPageRoute(
  //             builder: (_) => BottomBar(),
  //           ),
  //         );
  //         // RoutePage.navigatorKey.currentState!
  //         //     .pushNamedAndRemoveUntil(Home.id, (route) => false);
  //       },
  //       onError: (error) {
  //         AppException.onError(error);
  //       });
  // }
}
