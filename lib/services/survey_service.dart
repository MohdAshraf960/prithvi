import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';

import 'package:prithvi/models/model.dart';

class SurveyService {
  final FirebaseFirestore _firestore;
  SharedPreferencesService _sharedPreferencesService;

  SurveyService({
    required FirebaseFirestore firestore,
    required SharedPreferencesService sharedPreferencesService,
  })  : _firestore = firestore,
        _sharedPreferencesService = sharedPreferencesService;

  Future<void> addSurveyDocument(Map<String, double> surveyData) async {
    try {
      final user = UserModel.fromJson(_sharedPreferencesService.user);

      final userEmail = user.email;

      // Check if a document with the user's email already exists
      final docRef =
          FirebaseFirestore.instance.collection('survey').doc(userEmail);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // Document does not exist, create it
        surveyData.forEach((key, value) {
          surveyData[key] = surveyData.values.first;
          // num.parse(surveyData.values.first.toStringAsPrecision(2)).toDouble();
        });
        await docRef.set(surveyData);
      } else {
        // Document already exists, you can choose to update it or do nothing
        Logger().i(
            'Document with user email $userEmail already exists. $surveyData');

        addOrUpdateSurveyKey(surveyData.keys.first, surveyData.values.first);
      }
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  Future<void> addOrUpdateSurveyKey(String key, num value) async {
    try {
      final user = UserModel.fromJson(_sharedPreferencesService.user);

      final userEmail = user.email;

      // Get the reference to the user's survey document
      final docRef =
          _firestore.collection(FirebaseCollection.survey).doc(userEmail);

      // Retrieve the existing survey data
      final docSnapshot = await docRef.get();

      // Create or update the key within the survey data
      Map<String, dynamic> surveyData =
          docSnapshot.exists ? docSnapshot.data() as Map<String, dynamic> : {};
      surveyData[key] = value;

      // Set the updated survey data in the document
      await docRef.set(surveyData);
    } catch (e) {
      // TODO
      Logger().e(e);
    }
  }

  Stream<Map<String, dynamic>> getSurveyData() {
    final user = UserModel.fromJson(_sharedPreferencesService.user);

    final userEmail = user.email;

    // Get the reference to the user's survey document
    final docRef =
        _firestore.collection(FirebaseCollection.survey).doc(userEmail);

    // Return a stream of the survey data
    return docRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        // Return an empty map if the document doesn't exist
        return {};
      }
    });
  }
}
