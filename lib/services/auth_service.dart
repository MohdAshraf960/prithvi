import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

class AuthService {
  final FirebaseFirestore _firestore;

  AuthService({required FirebaseFirestore firestore}) : _firestore = firestore;

  /// Signs up a user with the provided [signUpData].
  /// Throws an [AppException] if the user already exists.
  Future<bool> signUpUser(SignUpModel signUpData) async {
    try {
      // Check if the user already exists
      if (await doesUserExist(signUpData.email, signUpData.phone)) {
        throw AppException(message: "User already exists");
      } else {
        // Create a new user
        await _firestore
            .collection(FirebaseCollection.user)
            .add(signUpData.toJson());
      }

      return true;
    } catch (e) {
      // Log the error or handle it as needed
      log("Error in signUpUser: $e");
      rethrow;
    }
  }

  /// Checks if a user with the given [email] or [phone] already exists.
  Future<bool> doesUserExist(String email, String phone) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection(FirebaseCollection.user)
          .where('email', isEqualTo: email)
          .get();

      QuerySnapshot phoneQuery = await _firestore
          .collection(FirebaseCollection.user)
          .where('phone', isEqualTo: phone)
          .get();

      return emailQuery.docs.isNotEmpty || phoneQuery.docs.isNotEmpty;
    } catch (e) {
      // Log the error or handle it as needed
      log("Error in doesUserExist: $e");
      rethrow;
    }
  }
}
