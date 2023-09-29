import 'package:flutter/material.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/questions_model.dart';

class SelectOptions extends StatelessWidget {
  const SelectOptions(
      {super.key, required this.questionsList, required this.index});

  final List<QuestionModel> questionsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Option>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: greyInputBorder, width: 1.0),
          ),
          hintText: "Select",
          contentPadding: const EdgeInsets.only(left: 16),
          labelStyle: TextStyle(
              fontSize: 16,
              color: grey3Color,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400),
        ),
        value: questionsList[index].selectedOption,
        onChanged: (Option? newValue) {
          questionsList[index].selectedOption = newValue;
        },
        items: questionsList[index].options.map((Option option) {
          return DropdownMenuItem<Option>(
            value: option,
            child: Text('${option.key}'),
          );
        }).toList(),
      ),
    );
  }
}
