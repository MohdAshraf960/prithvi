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

  Future<void> createOrUpdateTotalField({
    required String categoryName,
    //  required String uuid,
    required num categoryTotal,
  }) async {
    try {
      final user = UserModel.fromJson(_sharedPreferencesService.user);

      // Reference the subcollection within the user's document
      final collectionReference = _firestore
          .collection(FirebaseCollection.survey)
          .doc(user.email)
          .collection(categoryName);

      // Query the subcollection to find the document with the matching UUID
      final querySnapshot = await collectionReference.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Document with the given UUID exists, update the "total" field
        final documentReference = querySnapshot.docs.first.reference;
        await documentReference.update({
          'total': categoryTotal,
        });
        Logger().d('Document updated successfully');
      } else {
        // Document with the given UUID does not exist, create it with the "total" field
        final documentReference = collectionReference.doc();
        await documentReference.set({
          'total': categoryTotal,
        });
        Logger().d('Document created successfully');
      }
    } catch (e) {
      Logger().e('Error creating or updating document: $e');
      rethrow;
    }
  }

  getSurveyList() async {
    final user = UserModel.fromJson(_sharedPreferencesService.user);

    // Reference the document within the subcollection under the user's document
    final documentReference =
        _firestore.collection(FirebaseCollection.survey).doc(user.email);

    Logger().d(
        "documentReference ===> ${await documentReference.snapshots().first.then((value) => value.data())}");
  }
}
