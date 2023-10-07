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
          //1) find by string contains enigne,fuel,cateogry and add selected value to the map accordingly
          //2) table responses store map of dependant values
          //3) answers table actual containing calculated value from responses table calfactr,final answer
          //4) TODO: call car service

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
                } else if (widget.categoryType == "home") {
                  //TODO: set dependant values
                } else if (widget.categoryType == "diet") {
                  //TODO: set dependant values
                } else if (widget.categoryType == "other") {
                  //TODO: set dependant values
                }

                // Process car details here
                Logger().d("carDetails ${notifier.carDetails}");
              }
            } else {
              widget.onChanged(null);
              Logger().e("Exception ========= ${notifier.answersList}");
            }
          } else {
            widget.questionsList[widget.index].selectedOption = newValue;

            Logger().d(
                "OPTION ===> ${widget.questionsList[widget.index].selectedOption?.value.runtimeType}");
            if (widget.questionsList[widget.index].selectedOption?.value
                    .runtimeType !=
                String) {
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
