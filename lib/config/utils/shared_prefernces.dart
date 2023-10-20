// import 'package:prithvi/models/model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {
//   static SharedPreferences? _sharedPrefs;

//   // Private constructor to create an instance of SharedPreferencesService
//   SharedPreferencesService._();

//   // Factory constructor to ensure a single instance of SharedPreferencesService
//   factory SharedPreferencesService() {
//     if (_sharedPrefs == null) {
//       throw Exception("SharedPreferences not initialized");
//     }
//     return SharedPreferencesService._();
//   }

//   static Future<void> init() async {
//     _sharedPrefs ??= await SharedPreferences.getInstance();
//   }

//   // KEYS
//   static const String userKey = "userKey";
//   static const String isLoggedInKey = "isLoggedIn";

//   // GETTERS
//   String get user => _sharedPrefs!.getString(userKey) ?? "";
//   bool get isLoggedIn => _sharedPrefs!.getBool(isLoggedInKey) ?? false;

//   // SETTERS
//   void setUser(String user) {
//     _sharedPrefs!.setString(userKey, user);
//   }

//   void getUser() async {
//     final getuser = _sharedPrefs!.getString(userKey);
//     final sdd = UserModel.fromJson(getuser!);
//     print("getUser----------------->$sdd");
//   }

//   void setLoggedIn(bool isLoggedIn) {
//     _sharedPrefs!.setBool(isLoggedInKey, isLoggedIn);
//   }

//   // SETTER TO CLEAR PREFS FOR LOGOUT
//   void setLogout() {
//     _sharedPrefs?.clear();
//   }
// }
