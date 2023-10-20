import 'package:flutter/material.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/questions_model.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {super.key, required this.questionsList, required this.index});

  final List<QuestionModel> questionsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Autocomplete<Option>(
        initialValue: TextEditingValue(
            text: questionsList[index].selectedOption?.value ?? ""),
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return Iterable<Option>.empty();
          }

          return questionsList[index].options.where((Option option) {
            return option.value
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase());
          });
        },
        onSelected: (Option selectedOption) {
          questionsList[index].selectedOption = selectedOption;
          // Handle the selected option here
          print('Selected option: ${selectedOption.key}');
        },
        displayStringForOption: (Option option) => option.key,
        fieldViewBuilder: (BuildContext context,
            TextEditingController textEditingController,
            FocusNode focusNode,
            VoidCallback onFieldSubmitted) {
          return TextFormField(
            controller: textEditingController,
            focusNode: focusNode,
            onFieldSubmitted: (String value) {
              onFieldSubmitted();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyInputBorder, width: 1.0),
              ),
              suffixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyInputBorder, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: greyInputBorder, width: 1.0),
              ),
              hintText: 'Search here',
              contentPadding: const EdgeInsets.only(left: 16),
              labelStyle: TextStyle(
                  fontSize: 16,
                  color: grey3Color,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
