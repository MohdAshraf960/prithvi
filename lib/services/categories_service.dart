import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

class CategoriesService {
  final FirebaseFirestore _firestore;

  CategoriesService({required FirebaseFirestore firestore})
      : _firestore = firestore;

  /// Adds a list of categories to the Firestore database.
  /// Takes a list of [CategoryModel] objects as input.
  Future<void> addCategories(List<CategoryModel> categories) async {
    try {
      // Reference to the Firestore collection for categories
      CollectionReference categoryCollection =
          _firestore.collection(FirebaseCollection.categories);

      // Iterate through the list and add each category to the Firestore collection
      for (var category in categories) {
        await categoryCollection.doc(category.type).set(category.toJson());
      }
    } catch (e) {
      // Rethrowing the exception may be considered here if you want to handle it differently.
      rethrow;
    }
  }

  /// Retrieves a list of categories from the Firestore database.
  /// Returns a list of [CategoryModel] objects.
  Future<List<CategoryModel>> getCategoryList() async {
    try {
      // Query Firestore for all documents in the 'categories' collection
      QuerySnapshot querySnapshot = await _firestore
          .collection(FirebaseCollection.categories)
          .orderBy('createdAt')
          .get();

      // Map Firestore documents to CategoryModel objects
      List<CategoryModel> categories = querySnapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return categories;
    } catch (e) {
      return [];
    }
  }
}



//**
//  text
//  categoryRef
//  type-: mcq,input,slider
//  calculationFactor
//  options
// **/

