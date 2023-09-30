import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;
  final CarService _carService;
  List<QuestionModel> questionsList = [];
  List<String> answersList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //TODO: create maps for multilevel dropdown and try to calculate data
  Map<String, dynamic> carDetails = {
    "engineCC": "",
    "fuelType": "",
    "category": ""
  };

  QuestionsNotifier(
      {required QuestionsService questionsService,
      required CarService carService})
      : _questionsService = questionsService,
        _carService = carService;

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

  setCarValues() {
    final carCategory = questionsList
        .firstWhere((element) => element.text.contains("type of car"));

    final engineCapacity = questionsList.firstWhere(
        (element) => element.text.toLowerCase().contains("engine cc"));

    final fuel = questionsList
        .firstWhere((element) => element.text.contains("fuel used"));

    carDetails['category'] = carCategory.selectedOption?.key;
    carDetails['engineCC'] = engineCapacity.selectedOption?.key;
    carDetails['fuelType'] = fuel.selectedOption?.key;

    // Process car details here
    Logger().d("carDetails ${carDetails}");
    //TODO: call car service
  }
}
