import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';

import 'package:prithvi/models/questions_model.dart';

class SelectOptions extends ConsumerStatefulWidget {
  const SelectOptions({
    super.key,
    required this.questionsList,
    required this.index,
    required this.onChanged,
    required this.categoryType,
  });

  final List<QuestionModel> questionsList;
  final int index;
  final Function(Option?) onChanged;
  final String categoryType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectOptionsState();
}

class _SelectOptionsState extends ConsumerState<SelectOptions> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(questionNotifierProvider(widget.categoryType));

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
        value: widget.questionsList[widget.index].selectedOption,
        onChanged: (Option? newValue) {
          if (widget.questionsList[widget.index].isRelated) {
            final question = widget.questionsList[widget.index];
            final parentId = question.parentId;

            bool allChildIdsPresent = widget.questionsList
                .where((e) => e.childId != null)
                .expand((element) => element.childId!.toList())
                .any((childId) => notifier.answersList.contains(childId));

            if (parentId!.isEmpty || notifier.answersList.contains(parentId)) {
              question.selectedOption = newValue;

              if (!allChildIdsPresent) {
                notifier.addIds(question.id);
                Logger().d("answersList ${notifier.answersList}");
              } else {
                if (widget.categoryType == 'travel') {
                  notifier.setCarValues();
                  notifier.setBikeValues();
                } else if (widget.categoryType == "home") {
                } else if (widget.categoryType == "diet") {
                } else if (widget.categoryType == "other") {}

                // Process car details here
              }
            } else {
              widget.onChanged(null);
              Logger().d(
                  "QUESTION ===> ${question.id} PARENTID  ${question.parentId}");
              //  Logger().e("Exception ========= ${notifier.answersList}");
            }
          } else {
            widget.questionsList[widget.index].selectedOption = newValue;
            if (widget.categoryType == "travel") {
              notifier.setBikeValues();
            }
            Logger().d(
                "OPTION ===> ${widget.questionsList[widget.index].selectedOption}");
            if (widget.questionsList[widget.index].selectedOption?.value
                    .runtimeType !=
                String) {
              if (!widget.questionsList[widget.index].text
                  .contains("Which state do you live in?")) {
                notifier.calculationEmissionForMcq(widget.index);
              }
            }
            if (widget.categoryType == "other") {
              notifier.calculationEmissionForMcq(widget.index);
            }
          }
        },
        items: widget.questionsList[widget.index].options.map((Option option) {
          return DropdownMenuItem<Option>(
            value: option,
            child: Text('${option.key}'),
          );
        }).toList(),
      ),
    );
  }
}
