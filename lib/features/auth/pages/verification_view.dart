import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      //TODO: Navigate to Login Page
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
        child: Text("data "),
      ),
    );
  }
}
