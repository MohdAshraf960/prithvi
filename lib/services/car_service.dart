import 'package:cloud_firestore/cloud_firestore.dart';

class CarService {
  final FirebaseFirestore _firestore;

  CarService({required FirebaseFirestore firestore}) : _firestore = firestore;

  getCarDetails(
      {required String engineCC, required String fuelType, required category}) {
    // ignore: unused_local_variable
    Query query = _firestore
        .collection('cars')
        .where('engineCC', isEqualTo: engineCC)
        .where('fuelType', isEqualTo: fuelType)
        .where('category', isEqualTo: category);
  }
}
