import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/models/model.dart';

class AuthService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthService(
      {required FirebaseFirestore firestore,
      required FirebaseAuth firebaseAuth})
      : _firestore = firestore,
        _auth = firebaseAuth;

  /// Signs up a user with the provided [signUpData].
  /// Throws an [AppException] if the user already exists.
  Future<SignUpResult> signUpUser(SignUpModel signUpData) async {
    try {
      log("Error in signUpUser: $signUpData");
      // Check if the user already exists
      if (await doesUserExist(signUpData.email)) {
        throw AppException(message: "User already exists");
      }
      final authResult = await signUpWithEmail(signUpData: signUpData);
      if (authResult != null) {
        await addUserToFirestore(signUpData);
        await sendEmailVerification();
        return SignUpResult(success: true);
      }
      return SignUpResult(
          success: false, errorMessage: "User registration failed");
    } catch (e) {
      // Log the error or handle it as needed
      log("Error in signUpUser: $e");
      rethrow;
    }
  }

  /// Checks if a user with the given [email] already exists.
  Future<bool> doesUserExist(String email) async {
    try {
      QuerySnapshot emailQuery = await _firestore
          .collection(FirebaseCollection.user)
          .where('email', isEqualTo: email)
          .get();

      return emailQuery.docs.isNotEmpty;
    } catch (e) {
      // Log the error or handle it as needed
      log("Error in doesUserExist: $e");
      rethrow;
    }
  }

  /// Create a new user with [signUpData]
  Future<UserCredential?> signUpWithEmail(
      {required SignUpModel signUpData}) async {
    try {
      final authResult = await _auth.createUserWithEmailAndPassword(
        email: signUpData.email,
        password: signUpData.password,
      );

      return authResult;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = _auth.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUserToFirestore(SignUpModel user) async {
    try {
      await _firestore
          .collection(FirebaseCollection.user)
          .doc(user.email)
          .set(user.toJson());
      sendEmailVerification();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> checkEmailVerificationStatus() async {
    User user = _auth.currentUser!;
    await user.reload();
    user = _auth.currentUser!;
    bool flag = user.emailVerified;

    return flag;
  }

  Future<void> updateUserField(bool isVerified) async {
    try {
      final User user = _auth.currentUser!;
      // Get a reference to the user document you want to update
      final userReference =
          _firestore.collection(FirebaseCollection.user).doc(user.email);

      // Update the specific field using the update method
      await userReference.update(
        {
          'isVerified': isVerified,
          'uid': user.uid,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
