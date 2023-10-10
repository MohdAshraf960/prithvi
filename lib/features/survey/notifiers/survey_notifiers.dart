import 'package:flutter/material.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/services/services.dart';

class SurveyNotifier extends ChangeNotifier {
  final SharedPreferencesService _sharedPreferencesService;

  num totalEmission = 0.0;

  SurveyNotifier(
      {required SurveyService surveyService,
      required SharedPreferencesService sharedPreferencesService})
      : _sharedPreferencesService = sharedPreferencesService;

  getSurveyTotal() async {
    final home = await _sharedPreferencesService.homeEmission;
    final travel = await _sharedPreferencesService.travelEmission;

    print(home);

    print(travel);

    totalEmission = home + travel;
    notifyListeners();
  }
}
