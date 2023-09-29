import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;
  List<QuestionModel> questionsList = [];
  List<String> answersList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //TODO: create maps for multilevel dropdown and try to calculate data
  //Map<String, dynamic> carDetails = {"": "","":""};

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

  addIds(String id) {
    answersList.add(id);

    print("object ===> $answersList");
  }
}
