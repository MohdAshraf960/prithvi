import 'package:prithvi/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _secureStorage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // KEYS
  static const String userKey = "userKey";
  static const String isLoggedInKey = "isLoggedIn";
  static const String totalKey = "total";
  static const String homeKey = "homeKey";
  static const String travelKey = "travelKey";

  // GETTERS
  Future<String> getUser() async {
    final user = await _secureStorage.read(key: userKey);
    return user ?? "";
  }

  Future<bool> getIsLoggedIn() async {
    final isLoggedIn = await _secureStorage.read(key: isLoggedInKey);
    return isLoggedIn == "true";
  }

  Future<double> getTotalEmission() async {
    final total = await _secureStorage.read(key: totalKey);
    return double.parse(total ?? "0.0");
  }

  Future<double> getHomeEmission() async {
    final home = await _secureStorage.read(key: homeKey);
    return double.parse(home ?? "0.0");
  }

  Future<double> getTravelEmission() async {
    final travel = await _secureStorage.read(key: travelKey);
    return double.parse(travel ?? "0.0");
  }

  // SETTERS
  Future<void> setUser(String user) async {
    await _secureStorage.write(key: userKey, value: user);
  }

  Future<void> setIsLoggedIn(bool isLoggedIn) async {
    await _secureStorage.write(
        key: isLoggedInKey, value: isLoggedIn.toString());
  }

  Future<void> setTotalEmission(double total) async {
    await _secureStorage.write(key: totalKey, value: total.toString());
  }

  Future<void> setHomeEmission(double home) async {
    await _secureStorage.write(key: homeKey, value: home.toString());
  }

  Future<void> setTravelEmission(double travel) async {
    await _secureStorage.write(key: travelKey, value: travel.toString());
  }

  // SETTER TO CLEAR PREFS FOR LOGOUT
  Future<void> clearStorage() async {
    await _secureStorage.deleteAll();
  }
}
