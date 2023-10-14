import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prithvi/models/user_model.dart';

class SecureStorageService {
  final _secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // KEYS
  static const String userKey = "userKey";
  static const String isLoggedInKey = "isLoggedIn";

  // GETTERS
  Future<UserModel> getUser() async {
    final user = await _secureStorage.read(key: userKey);
    return UserModel.fromJson(user ??
        UserModel(uid: "uid", name: "name", email: "email", isVerified: false)
            .toJson());
  }

  Future<bool> getIsLoggedIn() async {
    final isLoggedIn = await _secureStorage.read(key: isLoggedInKey);
    return isLoggedIn == "true";
  }

  // SETTERS
  Future<void> setUser(String user) async {
    await _secureStorage.write(key: userKey, value: user);
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await _secureStorage.write(
        key: isLoggedInKey, value: isLoggedIn.toString());
  }

  // SETTER TO CLEAR PREFS FOR LOGOUT
  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }
}
