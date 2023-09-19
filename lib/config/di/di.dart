import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/features/features.dart';
import 'package:prithvi/services/services.dart';


// NOTIFIERS
final signUpProvider = ChangeNotifierProvider.autoDispose.family<SignUpNotifier, AuthService>((ref, authService) {
  return SignUpNotifier(authService: authService);
});

// SERVICES
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});


// why we use autodispose ==> becouse change value sometimes autodispose for example dynamic
// provider ==> does not change value for example static 