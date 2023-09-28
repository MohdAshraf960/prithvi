import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/widgets/textformfield.dart';
import 'package:prithvi/features/questions/questions.dart';
import 'package:prithvi/models/questions_model.dart';

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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final QuestionsNotifier(:isLoading, :questionsList) =
        ref.watch(questionNotifierProvider(widget.categoryType));
    print("$questionsList");
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
                  onPressed: () {
                    // if (widget.index < widget.tabController!.length - 1) {
                    //   widget.tabController
                    //       ?.animateTo(widget.index + 1); // Go to the next tab
                    // }

                    Logger().i(
                      "${questionsList.map((e) => e.calculationFactor)}",
                    );

                    Logger().i(
                      "${questionsList.where((element) => element.controller.text.isNotEmpty).map((e) => int.parse(e.controller.text) * e.calculationFactor)}",
                    );
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
