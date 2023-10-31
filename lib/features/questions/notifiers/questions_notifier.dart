import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/models/cars_model.dart';

import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class QuestionsNotifier extends ChangeNotifier {
  String? dietType;

  final QuestionsService _questionsService;
  final SurveyService _surveyService;

  // ignore: unused_field
  final CarService _carService;
  final BikeService _bikeService;
  List<QuestionModel> questionsList = [];
  List<String> answersList = [];

  List<QuestionModel> filteredDietList = [];

  CarModel? carModel;
  BikeModel? bikeModel;

  List<num> homeEmission = [];
  List<num> travelEmission = [];
  List<num> otherEmission = [];
  num homeEmissionTotal = 0.0;
  num travelEmissionTotal = 0.0;
  num otherEmissionTotal = 0.0;

  num carEmissionFactor = 0.0;

  // List<ChartData> chartList = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Map<String, dynamic> carDetails = {
    "engineCC": "",
    "fuelType": "",
    "category": ""
  };

  Map<String, dynamic> bikeDetails = {
    "engineCC": "",
    "fuelType": "Petrol",
    "category": ""
  };

  Map<String, dynamic> electricityState = {
    "state": "",
    "value": "",
  };

  QuestionsNotifier(
      {required QuestionsService questionsService,
      required CarService carService,
      required SurveyService surveyService,
      required BikeService bikeService})
      : _questionsService = questionsService,
        _carService = carService,
        _surveyService = surveyService,
        _bikeService = bikeService;

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

  setCarValues() async {
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

    carModel = await _carService.getCarDetails(
      engineCC: carDetails['engineCC'],
      fuelType: carDetails['fuelType'],
      category: carDetails['category'],
    );
  }

  setBikeValues() async {
    final bikeCategory = questionsList
        .firstWhere((element) => element.text.contains("type of 2 wheeler"));

    final engineCapacity = questionsList.firstWhere(
        (element) => element.text.toLowerCase().contains("bike engine cc"));

    bikeDetails['category'] = bikeCategory.selectedOption?.key ?? "";
    bikeDetails['engineCC'] = engineCapacity.selectedOption?.key ?? "";

    // Process car details here
    Logger().d("bikeDetails ${bikeDetails}");

    bikeModel = await _bikeService.getBikeDetails(
      engineCC: bikeDetails['engineCC'],
      fuelType: bikeDetails['fuelType'],
      category: bikeDetails['category'],
    );
    Logger().d("bikeModel ${bikeModel}");
  }

  setStateValues() {
    final state = questionsList.firstWhere((element) => element.text
        .toLowerCase()
        .contains("Which state do you live in?".toLowerCase()));

    electricityState['state'] = state.selectedOption?.key;
    electricityState['value'] = state.selectedOption?.value;

    Logger().d("electricity ${electricityState}");
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
            .toStringAsFixed(9),
      );
    }

    getCategory(index);
  }

  calculationEmissionForMcq(int index) {
    final parentId = questionsList[index].parentId;

    if (parentId!.isEmpty) {
      questionsList[index].calculatedValue = num.parse(
        ((questionsList[index].selectedOption?.value as num) *
                questionsList[index].calculationFactor)
            .toStringAsFixed(9),
      );

      getCategory(index);
    }
  }

  getCategory(int index) {
    final category = questionsList[index].categoryRef.path.split('/').last;
    final emission = questionsList.map((e) => e.calculatedValue).toList();
    final emissionTotal = num.parse(
      (emission.reduce((value, element) => value + element) / 1000)
          .toStringAsFixed(9),
    );

    createUpdateSurvey(categoryName: category, total: emissionTotal);

    Logger().f('$emission $category ===> $emissionTotal');
  }

  void createUpdateSurvey(
      {required String categoryName, required num total}) async {
    try {
      await _surveyService.addSurveyDocument({categoryName: total.toDouble()});
      await _surveyService
          .addOrUpdateSurveyDocument({categoryName: total.toDouble()});
    } catch (e) {
      AppException.onError(e);
    }
  }

  filterQuestionsByDietType({required String dietType}) {
    filteredDietList = (dietType.toLowerCase() == "veg")
        ? questionsList.where((element) => element.isVeg == true).toList()
        : questionsList;
    notifyListeners();

    Logger().i("filteredDietList ===$filteredDietList");
  }
}
