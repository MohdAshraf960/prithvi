import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'package:prithvi/models/model.dart';
import 'package:uuid/uuid.dart';

class BikeService {
  final FirebaseFirestore _firestore;

  BikeService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<BikeModel> getBikeDetails(
      {required String engineCC,
      required String fuelType,
      required category}) async {
    // ignore: unused_local_variable
    try {
      BikeModel bikeModel = BikeModel(
          id: Uuid().v4(),
          category: "category",
          engineCC: "engineCC",
          fuelType: "fuelType",
          value: 0);
      QuerySnapshot querySnapshot = await _firestore
          .collection('bikes')
          .where('engineCC', isEqualTo: engineCC)
          .where('fuelType', isEqualTo: fuelType)
          .where('category', isEqualTo: category)
          .get();

      // Process the querySnapshot to get the data
      List<DocumentSnapshot> documents = querySnapshot.docs;

      // Now you can access the data from the documents
      for (DocumentSnapshot document in documents) {
        Map<String, dynamic> carData = document.data() as Map<String, dynamic>;

        Logger().i('Bike Data : $carData');
        bikeModel = BikeModel.fromJson(carData);
      }
      return bikeModel;
    } catch (e) {
      rethrow;
    }
  }
}
