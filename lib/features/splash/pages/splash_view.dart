import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/core/routes/routes.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/features/dashboard/widgets/bottombar.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const id = '/';
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), _decideRoute);
  }

  _decideRoute() async {
    final sharedPreferencesService =
        ref.watch(sharedPreferencesServiceProvider);

    if (sharedPreferencesService.isLoggedIn) {
      goToPage(BottomBar.id);
    } else {
      goToPage(Login.id);
    }
  }

  goToPage(String pageRoute) {
    RoutePage.navigatorKey.currentState!
        .pushNamedAndRemoveUntil(pageRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
