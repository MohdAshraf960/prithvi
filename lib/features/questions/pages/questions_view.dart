import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/features/questions/questions.dart';

import 'package:prithvi/models/questions_model.dart';
import 'package:prithvi/services/services.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:uuid/uuid.dart';

class QuestionView extends ConsumerStatefulWidget {
  final String categoryType;
  final int index;
  final TabController? tabController;
  const QuestionView(
      {super.key,
      required this.categoryType,
      required this.index,
      this.tabController});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  @override
  Widget build(BuildContext context) {
    final QuestionsNotifier(:isLoading, :questionsList) =
        ref.watch(questionNotifierProvider(widget.categoryType));

    return Card(
      shadowColor: shadowColor,
      elevation: 0.5,
      color: white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: List.generate(
                        questionsList.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${index + 1})"),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      questionsList[index].text,
                                      style:
                                          TextStyle(fontSize: 16, color: grey),
                                    ),
                                  ),
                                ],
                              ),
                              if (questionsList[index].type ==
                                  QuestionType.Input)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AppFormField(
                                    labelText: "",
                                    controller: questionsList[index].controller,
                                    fontSize: 14,
                                    width: double.infinity,
                                    fontWeight: FontWeight.w400,
                                    height: 50,
                                    inputType: TextInputType.number,
                                  ),
                                ),
                              if (questionsList[index].type ==
                                  QuestionType.Slider)
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: SfSlider(
                                    activeColor: primaryGreen,
                                    inactiveColor:
                                        primaryGreen.withOpacity(0.4),
                                    min: questionsList[index]
                                        .options
                                        .first
                                        .value,
                                    max:
                                        questionsList[index].options.last.value,
                                    value: questionsList[index].sliderValue,
                                    interval:
                                        questionsList[index].options[1].value -
                                            questionsList[index]
                                                .options
                                                .first
                                                .value
                                                .toDouble(),
                                    showLabels: true,
                                    showDividers: true,

                                    onChanged: (value) {
                                      setState(() {
                                        questionsList[index].sliderValue =
                                            value;
                                      });
                                    },
                                    showTicks:
                                        true, // To show ticks on the slider
                                    // shouldAlwaysShowTooltip: true,
                                    // tooltipTextFormatterCallback:
                                    //     (dynamic actualValue,
                                    //         String formattedText) {
                                    //   var value;
                                    //   if (actualValue.runtimeType == double) {
                                    //     value = (actualValue as double).ceil();
                                    //   } else if (actualValue.runtimeType ==
                                    //       int) {
                                    //     value = actualValue;
                                    //   }

                                    //   return value.toString();
                                    // },
                                  ),
                                ),
                              if (questionsList[index].type == QuestionType.MCQ)
                                SelectOptions(
                                  index: index,
                                  categoryType: widget.categoryType,
                                  onChanged: (value) {
                                    setState(() {});
                                    if (value == null) {
                                      RoutePage.showErrorSnackbars(
                                          "Please select value from above dropdown");
                                    }
                                  },
                                  questionsList: questionsList,
                                  key: UniqueKey(),
                                ),
                              // if (questionsList[index].type ==
                              //         QuestionType.MCQ &&
                              //     questionsList[index].isSearchable == true)
                              //   SearchWidget(
                              //     questionsList: questionsList,
                              //     index: index,
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: widget.index != 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                // if (widget.index != 0)
                if (widget.index > 0)
                  ElevatedButton(
                    onPressed: () {
                      widget.tabController?.animateTo(widget.index - 1);
                    },
                    child: Text("Prev"),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    // if (widget.index < widget.tabController!.length - 1) {
                    //   widget.tabController
                    //       ?.animateTo(widget.index + 1); // Go to the next tab
                    // }

                    // Logger()
                    //     .i(questionsList.map((e) => e.sliderValue).toList());
                    // Logger()
                    //     .i(questionsList.map((e) => e.selectedOption).toList());
                    questionsList.map((e) {
                      Logger().i(e);
                    }).toList();

                    var uuid = Uuid();

                    // QuestionsService(firestore: FirebaseFirestore.instance)
                    //     .createQuestion(
                    //   question: QuestionModel(
                    //     id: uuid.v4(),
                    //     text: "What is the fuel used?",
                    //     type: QuestionType.MCQ,
                    //     options: [
                    //       Option(key: "Petrol", value: "Petrol"),
                    //       Option(key: "CNG", value: "CNG"),
                    //       Option(key: "Diesel", value: "Diesel"),
                    //     ],
                    //     calculationFactor: 0,
                    //     categoryRef:
                    //         FirebaseFirestore.instance.doc("categories/travel"),
                    //     timestamp: DateTime.now().microsecondsSinceEpoch,
                    //     unit: "",
                    //     parentId: "f9b54c9d-7985-4818-a1c5-dd8ad830581d",
                    //     childId: [],
                    //     isRelated: true,
                    //     isSearchable: false,
                    //   ),
                    // );
                  },
                  child: Text("Next"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
