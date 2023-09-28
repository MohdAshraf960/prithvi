import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prithvi/config/di/di.dart';
import 'package:prithvi/config/utils/shared_prefernces.dart';
import 'package:prithvi/core/core.dart';

import 'package:prithvi/features/splash/splash.dart';
import 'package:prithvi/firebase_options.dart';
import 'package:prithvi/models/questions_model.dart';
import 'package:prithvi/services/services.dart';

import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var uuid = Uuid();
  // QuestionsService(firestore: FirebaseFirestore.instance).addQuestions(
  //   questions: [
  //     QuestionModel(
  //       id: uuid.v4(),
  //       text:
  //           "How many kms have you travelled by non-suburban train in one year ?",
  //       type: QuestionType.Input,
  //       options: [],
  //       calculationFactor: 0.00794,
  //       categoryRef: FirebaseFirestore.instance.doc("categories/travel"),
  //       timestamp: DateTime.now().microsecondsSinceEpoch,
  //       unit: "kg CO2/Pax km",
  //       parentId: null,
  //       childId: [],
  //       isRelated: false,
  //     )
  //   ],
  // );

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
