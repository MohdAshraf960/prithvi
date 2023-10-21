import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/features/category/category.dart';
import 'package:prithvi/features/features.dart';
import 'package:prithvi/features/questions/questions.dart';
import 'package:prithvi/models/model.dart';

import 'package:prithvi/services/services.dart';

// ***************************************************************************
// SERVICES
// ***************************************************************************

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final userProvider = FutureProvider<UserModel>((ref) async {
  final secureStorage = ref.read(secureStorageServiceProvider);
  return await secureStorage.getUser();
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

final Provider<BikeService> bikeServiceProvider = Provider<BikeService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    return BikeService(firestore: firestore);
  },
);

final Provider<SurveyService> surveyServiceProvider = Provider<SurveyService>(
  (ref) {
    final firestore = ref.read(fireStoreProvider);
    final secureStorageService = ref.read(secureStorageServiceProvider);

    return SurveyService(
      firestore: firestore,
      secureStorageService: secureStorageService,
    );
  },
);

// ***************************************************************************
// NOTIFIERS
// ***************************************************************************

final questionNotifierProvider =
    ChangeNotifierProvider.family<QuestionsNotifier, String>(
  (ref, categoryType) {
    final QuestionsService questionsService =
        ref.watch(questionServiceProvider);
    final CarService carService = ref.watch(carServiceProvider);
    final SurveyService surveyService = ref.watch(surveyServiceProvider);
    final BikeService bikeService = ref.watch(bikeServiceProvider);

    return QuestionsNotifier(
        questionsService: questionsService,
        carService: carService,
        surveyService: surveyService,
        bikeService: bikeService)
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

    final SecureStorageService secureStorageService =
        ref.read(secureStorageServiceProvider);

    return SignInNotifier(
      authService: authService,
      secureStorageService: secureStorageService,
    );
  },
);
