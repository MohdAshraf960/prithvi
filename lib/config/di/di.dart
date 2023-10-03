import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/features/category/category.dart';
import 'package:prithvi/features/features.dart';
import 'package:prithvi/features/questions/questions.dart';
import 'package:prithvi/features/survey/notifiers/survey_notifiers.dart';

import 'package:prithvi/services/services.dart';

// ***************************************************************************
// SERVICES
// ***************************************************************************

final sharedPreferencesServiceInitializerProvider = Provider((ref) {
  SharedPreferencesService.init(); // Initialize SharedPreferencesService here
  return SharedPreferencesService();
});

// Provider for SharedPreferencesService
final sharedPreferencesServiceProvider =
    Provider<SharedPreferencesService>((ref) {
  final sharedPreferencesService =
      ref.read(sharedPreferencesServiceInitializerProvider);
  return sharedPreferencesService;
});

final Provider<FirebaseFirestore> fireStoreProvider =
    Provider<FirebaseFirestore>(
  (ref) {
    return FirebaseFirestore.instance;
  },
);

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final Provider<AuthService> authServiceProvider = Provider<AuthService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    final firebaseAuth = ref.watch(firebaseAuthProvider);
    return AuthService(firestore: firestore, firebaseAuth: firebaseAuth);
  },
);

final Provider<CategoriesService> categoryServiceProvider =
    Provider<CategoriesService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    return CategoriesService(firestore: firestore);
  },
);

final Provider<QuestionsService> questionServiceProvider =
    Provider<QuestionsService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    return QuestionsService(firestore: firestore);
  },
);

final Provider<CarService> carServiceProvider = Provider<CarService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    return CarService(firestore: firestore);
  },
);

final Provider<SurveyService> surveyServiceProvider = Provider<SurveyService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    final sharedPreference = ref.read(sharedPreferencesServiceProvider);

    return SurveyService(
      firestore: firestore,
      sharedPreferencesService: sharedPreference,
    );
  },
);

// ***************************************************************************
// NOTIFIERS
// ***************************************************************************

final ChangeNotifierProvider<SurveyNotifier> SurveyNotifierProvider =
    ChangeNotifierProvider<SurveyNotifier>(
  (ref) {
    final SurveyService surveyService = ref.watch(surveyServiceProvider);
    final SharedPreferencesService sharedPreferencesService =
        ref.watch(sharedPreferencesServiceProvider);

    return SurveyNotifier(
        surveyService: surveyService,
        sharedPreferencesService: sharedPreferencesService)
      ..getSurveyTotal();
  },
);

final questionNotifierProvider =
    ChangeNotifierProvider.family<QuestionsNotifier, String>(
  (ref, categoryType) {
    final QuestionsService questionsService =
        ref.watch(questionServiceProvider);
    final CarService carService = ref.watch(carServiceProvider);
    final SurveyService surveyService = ref.watch(surveyServiceProvider);
    final SharedPreferencesService sharedPreferencesService =
        ref.watch(sharedPreferencesServiceProvider);

    return QuestionsNotifier(
        questionsService: questionsService,
        carService: carService,
        surveyService: surveyService,
        sharedPreferencesService: sharedPreferencesService)
      ..getQuestionsList(categoryType: categoryType);
  },
);

final ChangeNotifierProvider<CategoryNotifier> categoryNotifierProvider =
    ChangeNotifierProvider<CategoryNotifier>(
  (ref) {
    final CategoriesService categoryServices =
        ref.read(categoryServiceProvider);

    return CategoryNotifier(
      categoriesService: categoryServices,
    )..getCategoryList();
  },
);

final ChangeNotifierProvider<SignUpNotifier> authStateNotifierProvider =
    ChangeNotifierProvider<SignUpNotifier>(
  (ref) {
    final AuthService authService = ref.read(authServiceProvider);

    return SignUpNotifier(
      authService: authService,
    );
  },
);

final ChangeNotifierProvider<SignInNotifier> signInStateNotifierProvider =
    ChangeNotifierProvider<SignInNotifier>(
  (ref) {
    final AuthService authService = ref.read(authServiceProvider);
    final SharedPreferencesService sharedPreferencesService =
        ref.read(sharedPreferencesServiceProvider);

    return SignInNotifier(
      authService: authService,
      sharedPreferencesService: sharedPreferencesService,
    );
  },
);
