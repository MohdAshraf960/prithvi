import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prithvi/features/auth/notifiers/sign_up_notfier.dart';
import 'package:prithvi/features/auth/pages/verification_view.dart';
import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/models/sign_up_model.dart';
import 'package:sizer/sizer.dart';

import '../../../config/di/di.dart';
import '../../../config/exception/exception.dart';

import '../../../config/utils/custom_button.dart';
import '../../../core/colors/colors.dart';

class SignUp extends ConsumerWidget {
  static const id = "/signup";
  SignUp({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Size size = MediaQuery.of(context).size;
    // var media = MediaQuery.of(context);

    Size size = MediaQuery.of(context).size;
    final media = MediaQuery.of(context);

    final authProvider = ref.watch(authStateNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(gradient: primaryGreenGradient),
          ),

          // Container(
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     image: DecorationImage(
          //       image: AssetImage(
          //         Assets.backgroundImage,
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
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
                  height: size.height * 0.6,
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
                                    //   height: 1.h,
                                    // ),
                                    Text(
                                      "Sign Up",
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
                                          color: textColor,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.3,
                                    ),
                                    AppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "this field is required";
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        // hintText: "Enter Email",
                                        // hintfontSize: 12.sp,
                                        labelText: "Enter Name",
                                        fontSize: 12.sp,
                                        controller: nameController,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.6,
                                    ),

                                    AppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "this field is required";
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        // hintText: "Enter Email",
                                        // hintfontSize: 12.sp,
                                        labelText: "Enter Email",
                                        fontSize: 12.sp,
                                        controller: emailController,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.6,
                                    ),

                                    AppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "this field is required";
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        // hintText: "Enter Email",
                                        // hintfontSize: 12.sp,
                                        labelText: "Enter Password",
                                        fontSize: 12.sp,
                                        controller: passwordController,
                                        fontWeight: FontWeight.w400),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.6,
                                    ),
                                    AppFormField(
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "this field is required";
                                          }
                                          if (value !=
                                              passwordController.text) {
                                            return "password do match";
                                          }
                                          return null;
                                        },
                                        inputType: TextInputType.text,
                                        height: size.height * 0.065,
                                        width: size.width,
                                        labelText: "Enter Confirm Password",
                                        fontSize: 12.sp,
                                        // suffixIcon: const Padding(
                                        //   padding: EdgeInsets.only(right: 16),
                                        //   child: Icon(
                                        //     Icons.remove_red_eye,
                                        //     color: backgroundColor,
                                        //   ),
                                        // ),

                                        controller: confirmPasswordController,
                                        fontWeight: FontWeight.w400),

                                    // ... rest of your form fields
                                    const SizedBox(
                                      height: kToolbarHeight * 0.5,
                                    ),
                                    authProvider.isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : CustomButton(
                                            textfontsize: 16,
                                            height: 6.h,
                                            textColor: whiteColor,
                                            color: primaryGreen,
                                            text: "SIGN UP",
                                            onTap: () {
                                              debugPrint("login button");
                                              formKey.currentState!.save();
                                              if (formKey.currentState!
                                                  .validate()) {
                                                _userSignUp(
                                                    authProvider, context);
                                              }
                                            },
                                            width: double.infinity,
                                          ),

                                    const SizedBox(
                                      height: kToolbarHeight * 1.18,
                                    ),
                                    // const SizedBox(
                                    //   height: 49.5,
                                    // ),
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

  _userSignUp(SignUpNotifier authProvider, context) {
    authProvider.userSignUp(
      userSignUpModel: SignUpModel(
        email: emailController.text,
        name: nameController.text,
        isVerified: false,
        password: passwordController.text,
      ),
      onError: (e) {
        AppException.onError(e);
      },
      onSuccess: ((result) {
        log("message $result");
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => VerificationPage(
              email: emailController.text,
            ),
          ),
        );
      }),
    );
  }
}
