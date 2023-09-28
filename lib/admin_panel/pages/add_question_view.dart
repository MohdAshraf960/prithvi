import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/constants/constants.dart';
import 'package:prithvi/admin_panel/notifiers/admin_questions_notifiers.dart';

import '../../models/questions_model.dart';

class AddQuestionForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddQuestionFormState();
}

class _AddQuestionFormState extends ConsumerState<AddQuestionForm> {
  TextEditingController textController = TextEditingController();
  QuestionType selectedType = QuestionType.Input;
  TextEditingController optionsController = TextEditingController();
  TextEditingController factorController = TextEditingController();
  TextEditingController timestampController = TextEditingController();
  String selectedCategory = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add a New Question',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Question Text'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<QuestionType>(
              value: selectedType,
              onChanged: (newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: QuestionType.values.map((type) {
                return DropdownMenuItem<QuestionType>(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Question Type'),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: ['Home', 'Food', 'Travel', 'Other'].map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Category'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: optionsController,
              decoration:
                  InputDecoration(labelText: 'Options (comma-separated)'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: factorController,
              decoration: InputDecoration(labelText: 'Calculation Factor'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Create a QuestionModel object with the entered data
                QuestionModel newQuestion = QuestionModel(
                  text: textController.text,
                  type: selectedType,
                  // this will throw error need to fix afterwards
                  options: [optionsController.text.split(',') as Option],
                  unit: "kwh",
                  calculationFactor: double.parse(factorController.text),
                  timestamp: DateTime.now().millisecondsSinceEpoch,
                  categoryRef: FirebaseFirestore.instance.doc(
                      "${FirebaseCollection.categories}/${selectedCategory.toLowerCase()}"),
                );
                // You can now use the 'newQuestion' object as needed.
                // For example, you can save it to a database or perform any other action.
                print(newQuestion);
                final adminNotifier = ref.read(adminNotifierProvider);

                //  await adminNotifier.createQuestion(questionModel: newQuestion);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
