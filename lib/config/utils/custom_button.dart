import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double? width;
  final double height;
  final Color color;
  final Color textColor;
  final double textfontsize;
  final void Function() onTap;

  const CustomButton(
      {super.key,
      required this.height,
      required this.text,
      required this.textColor,
      required this.color,
      required this.width,
      required this.onTap,
      required this.textfontsize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          border: Border.all(width: 0.4, color: Colors.transparent),
          borderRadius: BorderRadius.circular(12),
        ),
        height: height,
        width: width,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: textfontsize,
                fontWeight: FontWeight.w500,
                color: textColor),
          ),
        ),
      ),
    );
  }
}
