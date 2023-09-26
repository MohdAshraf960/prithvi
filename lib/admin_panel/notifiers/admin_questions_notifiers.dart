import 'package:flutter/material.dart';
import 'package:prithvi/admin_panel/services/category_service.dart';

import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/model.dart';

class AdminQuestionsNotifier extends ChangeNotifier {
  final AdminQuestionsService _questionsService;

  Stream<List<QuestionModel>>? questionsList;

  AdminQuestionsNotifier({required AdminQuestionsService questionsService})
      : _questionsService = questionsService;

  // Future<void> createQuestion({required QuestionModel questionModel}) async {
  //   try {
  //     await _questionsService.createQuestion(question: questionModel);
  //     await getQuestionsList();
  //   } catch (e) {
  //     AppException.onError(e);
  //   }
  // }

  Future<void> getQuestionsList() async {
    try {
      questionsList = _questionsService.getQuestionsStream();
      notifyListeners();
    } catch (e) {
      AppException.onError(e);
    }
  }
}
