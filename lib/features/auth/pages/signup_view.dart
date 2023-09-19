import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:sizer/sizer.dart';

import '../../../config/utils/assets.dart';
import '../../../config/utils/custom_button.dart';
import '../../../core/colors/colors.dart';

class SignUp extends StatelessWidget {
  
  static const id="/signup";
   SignUp({super.key});

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var media = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  Assets.backgroundImage,
                ),
                fit: BoxFit.cover,
              ),
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
                 
                  height: size.height * 0.7,
                  
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
                                top: size.height * 0.029,
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
                                      "SIGNUP",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          color: lableColor,
                                          fontSize: 24),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Text(
                                      "to your account ✨",
                                      style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          color: textColor,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: kToolbarHeight * 0.5,
                                    ),
                                   
                                        AppFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                           // controller: viewModel.email,
                                            fontWeight: FontWeight.w400),
                                        const SizedBox(
                                          height: kToolbarHeight * 0.7,
                                        ),
                                         AppFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "this field is required";
                                              }
                                              return null;
                                            },
                                            inputType: TextInputType.text,
                                            height: size.height * 0.065,
                                            width: size.width,
                                            // hintText: "Enter Email",
                                            // hintfontSize: 12.sp,
                                            labelText: "Enter Phone No",
                                            fontSize: 12.sp,
                                           // controller: viewModel.email,
                                            fontWeight: FontWeight.w400),
                                        const SizedBox(
                                          height: kToolbarHeight * 0.7,
                                        ),
                                         AppFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
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
                                           // controller: viewModel.email,
                                            fontWeight: FontWeight.w400),
                                        const SizedBox(
                                          height: kToolbarHeight * 0.7,
                                        ),
                                        AppFormField(
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return "this field is required";
                                              }
                                              return null;
                                            },
                                            inputType: TextInputType.text,
                                            height: size.height * 0.065,
                                            width: size.width,
                                            
                                            labelText: "Enter Confirm Password",
                                            fontSize: 12.sp,
                                            suffixIcon: const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 16),
                                              child: Icon(
                                                Icons.remove_red_eye,
                                                color: backgroundColor,
                                              ),
                                            ),
                                           // controller: viewModel.password,
                                            fontWeight: FontWeight.w400),
                      
                                    // ... rest of your form fields
                                     const SizedBox(
                                      height: kToolbarHeight * 0.5,
                                    ),
                                    CustomButton(
                                      textfontsize: 16,
                                      height: 6.h,
                                      textColor: whiteColor,
                                      color: backgroundColor,
                                      text: "SIGNUP",
                                      onTap: () {
                                        debugPrint("login button");
                                        formKey.currentState!.save();
                                        if (formKey.currentState!.validate()) {
                                          // viewModel.loginController(context);
                                        }
                                      },
                                      width: double.infinity,
                                    ),
                                  
                                      const SizedBox(
                                          height: kToolbarHeight * 0.3,
                                        ),
                                         const SizedBox(
                                          height: 55,
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
}