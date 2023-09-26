import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

class AdminQuestionsService {
  final FirebaseFirestore _firestore;
  late StreamController<List<QuestionModel>> _questionsController;

  AdminQuestionsService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  /// Retrieves a stream of questions from the Firestore database.
  Stream<List<QuestionModel>> getQuestionsStream() {
    try {
      // Reference to the collection where you want to fetch questions

      final CollectionReference questionsCollection =
          _firestore.collection(FirebaseCollection.quesitons);

      // Create a query for the collection, ordered by 'createdAt', and filtered by 'categoryRef'
      final Query query = questionsCollection.orderBy('createdAt');

      // Listen to the stream of snapshots and map them to QuestionModel objects
      query.snapshots().listen((snapshot) {
        final questions = snapshot.docs.map((doc) {
          final questionData = doc.data() as Map<String, dynamic>;
          final questionId = doc.id; // Get the document ID

          return QuestionModel.fromJson(questionData)
            ..documentId =
                questionId; // Set the document ID in the QuestionModel
        }).toList();

        _questionsController.add(questions); // Add questions to the stream
      });

      return _questionsController.stream;
    } catch (e) {
      Logger().e("error ======$e");
      return Stream.value([]); // Return an empty stream in case of an error
    }
  }
}
