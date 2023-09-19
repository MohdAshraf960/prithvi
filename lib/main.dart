import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/core/routes/routes.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        navigatorKey: RoutePage.navigatorKey,
        scaffoldMessengerKey: RoutePage.scaffoldMessengerKey,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        debugShowCheckedModeBanner: false,
        home: Login(),
        onGenerateRoute: (settings) => RoutePage.getPage(settings),
      ),
    );
  }
}
