import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/utils/utils.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/services/services.dart';

class VerificationPage extends ConsumerStatefulWidget {
  const VerificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 3),
      (timer) async {
        await checkEmailVerified();
      },
    );
  }

  checkEmailVerified() async {
    final result = await AuthService(
            firestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance)
        .checkEmailVerificationStatus();

    if (result) {
      timer.cancel();
      AuthService(
        firestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance,
      ).updateUserField(result);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/Email-Confirmation.png",
              fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Confirm Your email address',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "We sent a confirmation email to:",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "email@gmail.com",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Check your email and click on the\n confirmation link to continue",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: CustomButton(
                  height: 50,
                  text: "Verify",
                  textColor: Colors.white,
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width,
                  onTap: () {},
                  textfontsize: 16),
            )
          ],
        ),
      ),
    );
  }
}
