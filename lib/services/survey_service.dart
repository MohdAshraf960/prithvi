import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';

class SurveyService {
  final FirebaseFirestore _firestore;

  SecureStorageService _secureStorageService;

  SurveyService(
      {required FirebaseFirestore firestore,
      required SecureStorageService secureStorageService})
      : _firestore = firestore,
        _secureStorageService = secureStorageService;

  Future<void> addSurveyDocument(Map<String, double> surveyData) async {
    try {
      final user = await _secureStorageService.getUser();
      final userEmail = user.email;

      // Check if a document with the user's email already exists
      final docRef = FirebaseFirestore.instance
          .collection(FirebaseCollection.survey)
          .doc(userEmail);
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
      final user = await _secureStorageService.getUser();

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
      Logger().e(e);
    }
  }

  Stream<Map<String, dynamic>> getSurveyData() async* {
    final user = await _secureStorageService.getUser();
    final userEmail = user.email;

    final docRef =
        _firestore.collection(FirebaseCollection.survey).doc(userEmail);

    yield* docRef.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        return {};
      }
    });
  }

  Future<void> addOrUpdateSurveyDocument(Map<String, double> surveyData) async {
    try {
      final user = await _secureStorageService.getUser();
      final userEmail = user.email;

      final now = DateTime.now();
      final year = now.year;
      final month = now.month + 2;

      // Define the document path based on the year and month

      final docRef = FirebaseFirestore.instance
          .collection(FirebaseCollection.reports)
          .doc("$userEmail/$year/$month");

      // Get a reference to the document

      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // Document does not exist, create it
        await docRef.set({'surveyData': surveyData});
      } else {
        // Document already exists, update it with new survey data
        final existingData = docSnapshot.data() as Map<String, dynamic>;
        final existingSurveyData =
            existingData['surveyData'] as Map<String, dynamic>;

        // Merge the existing survey data with the new data
        surveyData.forEach((key, value) {
          existingSurveyData[key] = value;
        });

        await docRef.set({'surveyData': existingSurveyData});
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<List<Map<String, dynamic>>?> getSurveyDataByYear(int year) async {
    final user = await _secureStorageService.getUser();
    final userEmail = user.email;

    final surveyDataList = <Map<String, dynamic>>[];

    for (int month = 1; month <= 12; month++) {
      final docPath = "$userEmail/$year/$month";
      final docRef = FirebaseFirestore.instance
          .collection(FirebaseCollection.reports)
          .doc(docPath);

      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        final surveyData = data['surveyData'] as Map<String, dynamic>;
        surveyDataList.add({
          'year': year,
          'month': month,
          'surveyData': surveyData,
        });
      }
    }

    return surveyDataList.isNotEmpty ? surveyDataList : null;
  }
}
