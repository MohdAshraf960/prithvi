import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';

import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;
  final SurveyService _surveyService;

  // ignore: unused_field
  final CarService _carService;
  List<QuestionModel> questionsList = [];
  List<String> answersList = [];

  List<num> homeEmission = [];
  List<num> travelEmission = [];
  List<num> otherEmission = [];
  num homeEmissionTotal = 0.0;
  num travelEmissionTotal = 0.0;
  num otherEmissionTotal = 0.0;

  // List<ChartData> chartList = [];

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

  QuestionsNotifier({
    required QuestionsService questionsService,
    required CarService carService,
    required SurveyService surveyService,
  })  : _questionsService = questionsService,
        _carService = carService,
        _surveyService = surveyService;

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

  bool isStringValid(String inputString) {
    for (int i = 0; i < inputString.length; i++) {
      if (!isNumeric(inputString[i])) {
        return false; // Non-numeric character found
      }
    }
    return true; // All characters are numeric
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  calculateEmissionForInput(String value, int index) {
    if (isStringValid(value)) {
      questionsList[index].calculatedValue = num.parse(
        (double.tryParse(value)! * questionsList[index].calculationFactor)
            .toStringAsFixed(6),
      );
    }

    // Logger().e(
    //     "${questionsList[index].categoryRef.path.split("/").last}
    //  TEXT ${questionsList[index].text} =======
    //VALUE ${questionsList[index].calculatedValue}
    // === ${questionsList[index].calculationFactor}"
    // );
    getCategory(index);
  }

  calculationEmissionForMcq(int index) {
    questionsList[index].calculatedValue = num.parse(
      ((questionsList[index].selectedOption?.value as num) *
              questionsList[index].calculationFactor)
          .toStringAsFixed(6),
    );

    getCategory(index);
  }

  getCategory(int index) {
    final category = questionsList[index].categoryRef.path.split('/').last;
    final emission = questionsList.map((e) => e.calculatedValue).toList();
    final emissionTotal = num.parse(
      (emission.reduce((value, element) => value + element) / 1000)
          .toStringAsFixed(6),
    );

    createUpdateSurvey(categoryName: category, total: emissionTotal);

    // Logger().f('$category ===> $emissionTotal');
  }

  void createUpdateSurvey(
      {required String categoryName, required num total}) async {
    try {
      await _surveyService.addSurveyDocument({categoryName: total.toDouble()});
    } catch (e) {
      AppException.onError(e);
    }
  }
}
