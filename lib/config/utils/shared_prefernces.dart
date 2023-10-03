import 'package:prithvi/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _sharedPrefs;

  // Private constructor to create an instance of SharedPreferencesService
  SharedPreferencesService._();

  // Factory constructor to ensure a single instance of SharedPreferencesService
  factory SharedPreferencesService() {
    if (_sharedPrefs == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return SharedPreferencesService._();
  }

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  // KEYS
  static const String userKey = "userKey";
  static const String isLoggedInKey = "isLoggedIn";
  static const String totalKey = "total";
  static const String homeKey = "homeKey";
  static const String travelKey = "travelKey";

  // GETTERS
  String get user => _sharedPrefs!.getString(userKey) ?? "";
  bool get isLoggedIn => _sharedPrefs!.getBool(isLoggedInKey) ?? false;
  num get totalEmission => _sharedPrefs!.getDouble(totalKey) ?? 0.0;
  num get homeEmission => _sharedPrefs!.getDouble(homeKey) ?? 0.0;
  num get travelEmission => _sharedPrefs!.getDouble(travelKey) ?? 0.0;

  // SETTERS
  void setUser(String user) {
    _sharedPrefs!.setString(userKey, user);
  }

  void getUser() async {
    final getuser = _sharedPrefs!.getString(userKey);
    final sdd = UserModel.fromJson(getuser!);
    print("getUser----------------->$sdd");
  }

  void setLoggedIn(bool isLoggedIn) {
    _sharedPrefs!.setBool(isLoggedInKey, isLoggedIn);
  }

  setTotal(num total) {
    _sharedPrefs!.getDouble(totalKey);
  }

  setHomeTotal(num total) {
    _sharedPrefs!.getDouble(homeKey);
  }

  setTravelTotal(num total) {
    _sharedPrefs!.getDouble(travelKey);
  }

  // SETTER TO CLEAR PREFS FOR LOGOUT
  void setLogout() {
    _sharedPrefs?.clear();
  }
}

// Initialize SharedPreferencesService elsewhere in your code
// Example:
// await SharedPreferencesService.init();
// final sharedPrefs = SharedPreferencesService();
