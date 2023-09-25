import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/core/core.dart';

class QuestionView extends ConsumerStatefulWidget {
  final String questions;
  final int index;
  const QuestionView({super.key, required this.questions, required this.index});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionViewState();
}

class _QuestionViewState extends ConsumerState<QuestionView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: shadowColor,
      elevation: 0.5,
      color: white,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(
                  10,
                  (index) => Text(
                    "${index + 1}",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: widget.index == 0
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (widget.index == 0)
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Prev"),
                  ),
                ElevatedButton(
                  onPressed: () {},
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
