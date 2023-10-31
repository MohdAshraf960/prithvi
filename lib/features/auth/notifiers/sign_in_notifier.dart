import 'package:flutter/foundation.dart';

import 'package:prithvi/config/utils/secure_storage.dart';

import 'package:prithvi/models/model.dart';
import 'package:prithvi/services/services.dart';

class SignInNotifier extends ChangeNotifier {
  bool _isLoading = false;
  final AuthService _authService;

  final SecureStorageService _secureStorageService;

  SignInNotifier({
    required AuthService authService,
    required SecureStorageService secureStorageService,
  })  : _authService = authService,
        _secureStorageService = secureStorageService;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void userSignIn({
    required SignInModel userSignInModel,
    required Function(UserModel result) onSuccess,
    required Function(Object e) onError,
  }) async {
    try {
      isLoading = true;

      final userResult =
          await _authService.signInUser(signInModel: userSignInModel);
      if (userResult != null) {
        // If signup was successful, call the onSuccess callback
        await _storeUserInSharedPreferences(userResult);
        onSuccess(userResult);
      } else {
        // If signup failed, call the onError callback with the error message
        //onError();
        throw Exception('Unable to login');
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      // If an exception occurred, call the onError callback with the exception
      onError(e);
      // Optionally, log the error for debugging purposes
      //Logger().e('Error during sign-in: $e');
    }
  }

  Future<void> _storeUserInSharedPreferences(UserModel user) async {
    final userJson = user.toJson(); // Assuming UserModel has a `toJson` method
    // Store the user object as a JSON string in SharedPreferences

    _secureStorageService.setUser(userJson);
    _secureStorageService.setIsLoggedIn(true);
  }
}
