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
          .where('isActive', isEqualTo: true)
          .get();

      // Map Firestore documents to QuestionModel objects
      List<QuestionModel> questions = querySnapshot.docs
          .map((doc) =>
              QuestionModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      Logger().i("questions ======$questions");
      return questions;
    } catch (e) {
      Logger().e("error ======$e");
      return [];
    }
  }

  Future<void> createQuestion({required QuestionModel question}) async {
    try {
      // Reference to the collection where you want to add the question
      CollectionReference questionsCollection =
          _firestore.collection(FirebaseCollection.quesitons);

      // Add the question data to the collection
      await questionsCollection
          .doc('${question.categoryRef.path.split('/').last}-${question.id}')
          .set(question.toMap());
      Logger().i("Question created sucessfuly");
    } catch (e) {
      Logger().e("error creating question: $e");
      rethrow;
    }
  }

// Function to add the "isActive" field to all documents
  Future<void> addIsActiveFieldToAllQuestions() async {
    try {
      // Reference to the Firestore collection
      CollectionReference questionsCollection =
          FirebaseFirestore.instance.collection(FirebaseCollection.quesitons);

      // Fetch all documents in the collection
      QuerySnapshot questionsSnapshot = await questionsCollection.get();

      // Loop through each document and add the "isActive" field
      questionsSnapshot.docs.forEach((doc) async {
        // Check if the "isActive" field doesn't already exist in the document

        await doc.reference.update({'isActive': true});
        print('Added "isActive" field to document ${doc.id}');
      });

      print('Added "isActive" field to all documents');
    } catch (e) {
      print('Error adding "isActive" field: $e');
    }
  }

  // Function to set "isActive" to false for documents with "isRelated" as true
  Future<void> setActiveForRelatedQuestions() async {
    try {
      // Reference to the Firestore collection
      CollectionReference questionsCollection =
          FirebaseFirestore.instance.collection('questions');

      // Query for documents where "isRelated" is true
      QuerySnapshot relatedQuestionsSnapshot =
          await questionsCollection.where('isRelated', isEqualTo: true).get();

      // Loop through each related document and set "isActive" to true
      relatedQuestionsSnapshot.docs.forEach((doc) async {
        await doc.reference.update({'isActive': false});
        print('Set "isActive" to true for document ${doc.id}');
      });

      print('Set "isActive" to true for related questions');
    } catch (e) {
      print('Error setting "isActive" for related questions: $e');
    }
  }
}
