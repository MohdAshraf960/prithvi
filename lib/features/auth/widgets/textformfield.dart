import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prithvi/core/colors/colors.dart';
import 'package:sizer/sizer.dart';

class AppFormField extends StatelessWidget {
  // final String hintText;
  // final double hintfontSize;
  final String? fontStyles;
  final String labelText;
  final String? hint;

  final double fontSize;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final TextInputType inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double width;
  final double height;
  final FocusNode? focus;
  final bool readonly;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;

  final FontWeight fontWeight;
  const AppFormField(
      {Key? key,
      //required this.hintText,
      this.onTap,
      this.onChanged,
      this.validator,
      this.inputType = TextInputType.text,
      this.inputAction,
      // required this.hintfontSize,
      this.fontStyles,
      this.obscureText = false,
      required this.labelText,
      required this.fontSize,
      this.suffixIcon,
      this.controller,
      required this.width,
      required this.height,
      this.focus,
      this.readonly = false,
      required this.fontWeight,
      this.hint,
      this.onFieldSubmitted,
      this.inputFormatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      height: 6.h,
      // height: height, // size.height * 0.065,
      width: width, //size.width, //size.width,
      child: TextFormField(
        onChanged: onChanged,
        onTap: onTap,

        textInputAction: inputAction,
        //textCapitalization: TextCapitalization.sentences,
        validator: validator,
        keyboardType: inputType,
        obscureText: obscureText,
        controller: controller,
        focusNode: focus,
        // autofocus: true,
        readOnly: readonly,
        style: TextStyle(
          fontSize: fontSize,
          color: grey,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight,
        ),
        cursorColor: grey,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: suffixIcon,
          // suffixIconColor: Colors.amber,
          // suffixIconConstraints:
          //     const BoxConstraints(maxHeight: 34, maxWidth: 34),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),

          hintText: hint,
          contentPadding: const EdgeInsets.only(left: 16),

          labelText: labelText,
          labelStyle: TextStyle(
              fontSize: 16,
              color: grey3Color,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
        ),
        onFieldSubmitted: onFieldSubmitted,
        inputFormatters: inputFormatter,
      ),
    );
  }
}
