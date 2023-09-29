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
      Logger().i("questions ======$questions");
      return questions;
    } catch (e) {
      Logger().e("error ======$e");
      return [];
    }
  }
  // Stream<List<QuestionModel>> getQuestionsList({required String categoryType}) {
  //   try {
  //     // Create a reference to the Firestore collection
  //     final collectionRef = _firestore.collection(FirebaseCollection.quesitons);

  //     // Create a query to filter by 'categoryRef'
  //     final query = collectionRef.orderBy('createdAt').where(
  //           'categoryRef',
  //           isEqualTo: _firestore
  //               .doc('${FirebaseCollection.categories}/$categoryType'),
  //         );

  //     // Create a stream of snapshots and map them to QuestionModel objects
  //     final stream = query.snapshots().map((querySnapshot) {
  //       return querySnapshot.docs.map((doc) {
  //         return QuestionModel.fromJson(doc.data());
  //       }).toList();
  //     });

  //     return stream;
  //   } catch (e) {
  //     Logger().e("error ======$e");
  //     return Stream.value([]); // Return an empty stream in case of an error
  //   }
  // }

  Future<void> createQuestion({required QuestionModel question}) async {
    try {
      // Reference to the collection where you want to add the question
      CollectionReference questionsCollection =
          _firestore.collection(FirebaseCollection.quesitons);

      // Add the question data to the collection
      await questionsCollection
          .doc('${question.categoryRef.path.split('/').last}-${question.id}')
          .set(question.toMap());
    } catch (e) {
      Logger().e("error creating question: $e");
      rethrow;
    }
  }
}
