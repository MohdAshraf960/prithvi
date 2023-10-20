import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/models/cars_model.dart';
import 'package:uuid/uuid.dart';

class CarService {
  final FirebaseFirestore _firestore;

  CarService({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<CarModel> getCarDetails(
      {required String engineCC,
      required String fuelType,
      required category}) async {
    // ignore: unused_local_variable
    try {
      CarModel carModel = CarModel(
          id: Uuid().v4(),
          category: "category",
          engineCC: "engineCC",
          fuelType: "fuelType",
          value: 0);
      QuerySnapshot querySnapshot = await _firestore
          .collection('cars')
          .where('engineCC', isEqualTo: engineCC)
          .where('fuelType', isEqualTo: fuelType)
          .where('category', isEqualTo: category)
          .get();

      // Process the querySnapshot to get the data
      List<DocumentSnapshot> documents = querySnapshot.docs;

      // Now you can access the data from the documents
      for (DocumentSnapshot document in documents) {
        Map<String, dynamic> carData = document.data() as Map<String, dynamic>;

        // Access specific fields from carData
        // String carName = carData['carName'];
        // int carYear = carData['carYear'];

        // Do something with the car data
        Logger().i('Car Data : $carData');
        carModel = CarModel.fromJson(carData);
      }
      return carModel;
    } catch (e) {
      rethrow;
    }
  }
}
