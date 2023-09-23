import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/features/features.dart';
import 'package:prithvi/services/services.dart';

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
