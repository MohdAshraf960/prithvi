import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

class QuestionsService {
  final FirebaseFirestore _firestore;

  QuestionsService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> addQuestions({required List<QuestionModel> questions}) async {
    // Initialize a Firestore instance

    // Create a batch
    WriteBatch batch = _firestore.batch();

    // Reference to the collection where you want to add the questions
    CollectionReference questionsCollection =
        _firestore.collection(FirebaseCollection.quesitons);

    for (QuestionModel question in questions) {
      // Create a new document reference with an automatically generated ID
      DocumentReference docRef = questionsCollection.doc();

      // Set the document data using the toMap() method of your QuestionModel
      batch.set(docRef, question.toMap());
    }

    // Commit the batch
    await batch.commit();
  }

  /// Retrieves a list of questions from the Firestore database.
  /// Returns a list of [QuestionModel] objects.
  Future<List<QuestionModel>> getQuestionsList(
      {required String categoryType}) async {
    try {
      // Query Firestore for all documents in the 'QuestionModel' collection
      QuerySnapshot querySnapshot = await _firestore
          .collection(FirebaseCollection.quesitons)
          .orderBy('createdAt')
          .where(
            'categoryRef',
            isEqualTo: _firestore.doc(
              '${FirebaseCollection.categories}/$categoryType',
            ),
          )
          .get();

      // Map Firestore documents to QuestionModel objects
      List<QuestionModel> questions = querySnapshot.docs
          .map((doc) =>
              QuestionModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return questions;
    } catch (e) {
      Logger().e("error ======$e");
      return [];
    }
  }
}
