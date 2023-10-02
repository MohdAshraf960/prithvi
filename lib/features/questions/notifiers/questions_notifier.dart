import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/features/home/pages/home_view.dart';
import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  final QuestionsService _questionsService;
  // ignore: unused_field
  final CarService _carService;
  List<QuestionModel> questionsList = [];
  List<String> answersList = [];
  List reponseList = [];

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

  calculateEmissionValue(String categoryType, int index) {
    Logger().d("CATEGORY TYPE ==> $categoryType");
    // reponseList.clear();
    if (isStringValid(questionsList[index].controller.text)) {
      if (questionsList[index].isRelated) {
        //TODO: handle on change logic for related fields
      } else {
        if (questionsList[index].type == QuestionType.Input) {
          questionsList[index].calculatedValue =
              double.parse(questionsList[index].controller.text) *
                  questionsList[index].calculationFactor;
        }
        if (questionsList[index].type == QuestionType.MCQ) {
          questionsList[index].calculatedValue =
              questionsList[index].calculationFactor;
        }
      }

      print(
          "$categoryType calculatedValue ==> ${questionsList[index].calculatedValue}");
      calculateDataCategoryWise(categoryType);
    }
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

  void calculateDataCategoryWise(String category) {
    final categoryQuestions = questionsList
        .where((element) => element.categoryRef.path.contains(category));

    Logger().d("categoryQuestions   $categoryQuestions");

    if (categoryQuestions.isNotEmpty) {
      final output = categoryQuestions
          .map((e) => e.calculatedValue)
          .reduce((value, element) => value + element);
      Logger().d("output  ==== $output");
      // Check if the category already exists in chartList
      // final existingCategoryIndex = chartList.indexWhere((chartData) =>
      //     chartData.category.toLowerCase() == category.toLowerCase());

      // if (existingCategoryIndex != -1) {
      //   // If the category exists, update its value
      //   chartList[existingCategoryIndex].value = output.toDouble();
      // } else {
      //   // If the category does not exist, add it to chartList

      //  I m doing comment here  // chartList.add(ChartData(category, output.toDouble()));
      // }
    }
    Logger().f("category   $category");
    //  Logger().f("chartList  ==== $chartList");

    // chartList = chartList.toSet().toList();

    notifyListeners();
  }
}
