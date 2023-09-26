import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prithvi/config/utils/shared_prefernces.dart';
import 'package:prithvi/core/core.dart';

import 'package:prithvi/features/splash/splash.dart';
import 'package:prithvi/firebase_options.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        navigatorKey: RoutePage.navigatorKey,
        scaffoldMessengerKey: RoutePage.scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: GoogleFonts.openSansTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          primaryColor: primaryGreen,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: primaryGreen,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              maximumSize: MaterialStateProperty.all(Size.fromHeight(50)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.all<Color>(primaryGreen),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.id,
        onGenerateRoute: (settings) => RoutePage.getPage(settings),
      ),
    );
  }
}
