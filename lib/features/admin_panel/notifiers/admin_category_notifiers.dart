import 'package:flutter/material.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class AdminCategoryNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;

  AdminCategoryNotifier({required QuestionsService questionsService})
      : _questionsService = questionsService;

  Future<void> addCategory({required QuestionModel questionModel}) async {
    try {
      _questionsService.addQuestions(questions: [questionModel]);
    } catch (e) {}
  }
}
