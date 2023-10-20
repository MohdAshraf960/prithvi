import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/features/questions/widgets/select_options.dart';
import 'package:prithvi/models/questions_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class DietQuestionView extends ConsumerStatefulWidget {
  final String categoryType;
  final int index;
  final TabController? tabController;
  const DietQuestionView({
    required this.categoryType,
    required this.index,
    this.tabController,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DietQuestionViewState();
}

class _DietQuestionViewState extends ConsumerState<DietQuestionView> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(questionNotifierProvider(widget.categoryType));

    Logger().i("${notifier.questionsList}");
    return Card(
      shadowColor: shadowColor,
      elevation: 0.5,
      color: white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1)"),
                      SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: Text(
                          "What is your diet type?",
                          style: TextStyle(fontSize: 16, color: grey),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: notifier.dietType,
                      items: ["Veg", "Non Veg"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: greyInputBorder, width: 1.0),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: greyInputBorder, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: greyInputBorder, width: 1.0),
                        ),
                        hintText: "Select",
                        contentPadding: const EdgeInsets.only(left: 16),
                        labelStyle: TextStyle(
                            fontSize: 16,
                            color: grey3Color,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400),
                      ),
                      onChanged: (value) {
                        notifier.dietType = value;
                        notifier.filterQuestionsByDietType(
                          dietType: value!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: notifier.filteredDietList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${index + 2})"),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                notifier.filteredDietList[index].text,
                                style: TextStyle(fontSize: 16, color: grey),
                              ),
                            ),
                          ],
                        ),
                        if (notifier.filteredDietList[index].type ==
                            QuestionType.Input)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppFormField(
                              labelText: "",
                              controller:
                                  notifier.filteredDietList[index].controller,
                              fontSize: 14,
                              width: double.infinity,
                              fontWeight: FontWeight.w400,
                              height: 50,
                              inputType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                calculateEmissionOnChanged(value, index);
                              },
                              onFieldSubmitted: (value) {},
                            ),
                          ),
                        if (notifier.filteredDietList[index].type ==
                            QuestionType.Slider)
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: SfSlider(
                              activeColor: primaryGreen,
                              inactiveColor: primaryGreen.withOpacity(0.4),
                              min: notifier
                                  .filteredDietList[index].options.first.value,
                              max: notifier
                                  .filteredDietList[index].options.last.value,
                              value:
                                  notifier.filteredDietList[index].sliderValue,
                              interval: notifier.filteredDietList[index]
                                      .options[1].value -
                                  notifier.filteredDietList[index].options.first
                                      .value
                                      .toDouble(),
                              showLabels: true,
                              showDividers: true,

                              onChanged: (value) {
                                setState(() {
                                  notifier.filteredDietList[index].sliderValue =
                                      value;
                                });
                              },
                              showTicks: true, // To show ticks on the slider
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
                        if (notifier.filteredDietList[index].type ==
                            QuestionType.MCQ)
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
                            questionsList: notifier.filteredDietList,
                            key: UniqueKey(),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: widget.index != 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (widget.index > 0)
                  ElevatedButton(
                    onPressed: () {
                      widget.tabController?.animateTo(widget.index - 1);
                      // notifier.filteredDietList.map((e) =>
                      //     print("text ${e.text}  timestamp ${e.timestamp}"));
                    },
                    child: Text("Prev"),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if (widget.index < widget.tabController!.length - 1) {
                      widget.tabController
                          ?.animateTo(widget.index + 1); // Go to the next tab
                    }

                    // QuestionsService(firestore: FirebaseFirestore.instance)
                    //     .createQuestion(
                    //   question: QuestionModel(
                    //     id: Uuid().v4(),
                    //     text:
                    //         "How many single use plastic bags do you use in a year?",
                    //     type: QuestionType.Input,
                    //     options: [],
                    //     calculationFactor: 1.58,
                    //     categoryRef: FirebaseFirestore.instance
                    //         .doc("${FirebaseCollection.categories}/other"),
                    //     timestamp: DateTime.now().microsecondsSinceEpoch,
                    //     unit: "kg",
                    //     isActive: true,
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

  void calculateEmissionOnChanged(String value, int index) {
    final questionNotifier = ref.read(
      questionNotifierProvider(widget.categoryType),
    );
    Future.delayed(Duration(milliseconds: 500), () {
      if (value.trim().isNotEmpty) {
        questionNotifier.calculateEmissionForInput(value, index);
      } else {
        questionNotifier.calculateEmissionForInput("0", index);
      }
    });
  }
}
