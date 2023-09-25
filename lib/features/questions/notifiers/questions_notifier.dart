import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;
  List<QuestionModel> questionsList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  QuestionsNotifier({required QuestionsService questionsService})
      : _questionsService = questionsService;

  void getQuestionsList({required categoryType}) async {
    try {
      isLoading = true;
      questionsList =
          await _questionsService.getQuestionsList(categoryType: categoryType);
      isLoading = false;
      Logger().i("${questionsList}");
    } catch (e) {
      isLoading = false;
      AppException.onError(e);
    }
  }
}
