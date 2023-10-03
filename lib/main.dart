import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:prithvi/config/utils/shared_prefernces.dart';
import 'package:prithvi/core/core.dart';

import 'package:prithvi/features/splash/splash.dart';
import 'package:prithvi/firebase_options.dart';
import 'package:prithvi/services/firebase_analytics.dart';
import 'package:prithvi/services/locator.dart';

import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setUpLocator();

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        navigatorKey: RoutePage.navigatorKey,
        navigatorObservers: [
          locator<AnalyticsServices>().getAnalyticsObserver()
        ],
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
        // home: Login(),
        onGenerateRoute: (settings) => RoutePage.getPage(settings),
      ),
    );
  }
}

//**
//  input calculation store value in calculatedValue then add all values
//  mcq calculation store value in calculatedValue then add all values
// */

Future<void> createSurvey(
    String userEmail, String subcollectionName, int total) async {
  try {
    final firestore = FirebaseFirestore.instance;

    // Create a document with the user's email as the ID
    final userDoc = firestore.collection('survey').doc(userEmail);

    // Create a subcollection with the passed name
    final subcollection = userDoc.collection(subcollectionName);

    // Create a document in the subcollection with the "total" field
    final documentRef = await subcollection.add({'total': total});

    print('Survey created successfully with ID: ${documentRef.id}');
  } catch (e) {
    print('Error creating survey: $e');
  }
}
