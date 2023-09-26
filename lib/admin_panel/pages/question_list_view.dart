import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/admin_panel/admin_panel.dart';

class QuestionList extends ConsumerStatefulWidget {
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends ConsumerState<QuestionList> {
  @override
  void initState() {
    super.initState();
    ref.read(adminNotifierProvider).getQuestionsList();
  }

  @override
  Widget build(BuildContext context) {
    final AdminQuestionsNotifier() = ref.watch(adminNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Question List'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddQuestionForm()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Text')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Options')),
            DataColumn(label: Text('Calculation Factor')),
            DataColumn(label: Text('Timestamp')),
            DataColumn(label: Text('Category')),
            DataColumn(label: Text('Edit')),
            DataColumn(label: Text('Delete')),
          ],
          rows: questionsList.map((question) {
            return DataRow(
              cells: [
                DataCell(Text(question.text)),
                DataCell(Text(question.type.toString().split('.').last)),
                DataCell(Text(question.options.join(', '))),
                DataCell(Text(question.calculationFactor.toString())),
                DataCell(Text(question.timestamp.toString())),
                DataCell(Text(question.categoryRef.path)),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Handle edit action here
                      // You can navigate to the edit form and pass the question data
                      // or open a dialog for editing
                      print('Edit button pressed for ${question.text}');
                    },
                  ),
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle delete action here
                      // You can show a confirmation dialog before deleting
                      print('Delete button pressed for ${question.documentId}');
                    },
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
