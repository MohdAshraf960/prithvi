import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/questions/questions.dart';
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
            final parentId = widget.questionsList[widget.index].parentId;

            if (parentId!.isEmpty || notifier.answersList.contains(parentId)) {
              widget.questionsList[widget.index].selectedOption = newValue;
              notifier.addIds(widget.questionsList[widget.index].id);
              print(
                  "object1 ========= ${widget.questionsList[widget.index].id}  ${notifier.answersList}");
            } else {
              final result = widget.questionsList
                  .firstWhere((element) => element.id == parentId);
              print("findParent =======> $parentId");
              print("RESULT =======> $result");

              if (result.selectedOption != null) {
                print(
                    "object2 ========= ${result.selectedOption} ${notifier.answersList}");
                // TODO: call car service
              } else {
                widget.onChanged(null);
              }
              print("object2 ========= ${notifier.answersList}");
            }
          } else {
            widget.questionsList[widget.index].selectedOption = newValue;
          }
        },
        items: widget.questionsList[widget.index].options.map((Option option) {
          return DropdownMenuItem<Option>(
            value: option,
            child: Text('${option.value}'),
          );
        }).toList(),
      ),
    );
  }
}
