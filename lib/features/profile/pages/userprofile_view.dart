import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';

import 'package:sizer/sizer.dart';

import '../../auth/widgets/textformfield.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const id = "/username";

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data from SharedPreferences when the widget initializes
    getUser();
  }

  // Method to fetch user data from SharedPreferences
  void getUser() async {
    final securedStorageService = ref.read(secureStorageServiceProvider);

    final user = await securedStorageService.getUser();

    if (user.isVerified) {
      setState(() {
        nameController.text = user.name;
        emailController.text = user.email;
      });
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginView.id,
        (route) => false,
      );
    }
  }

  bool isDisable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        elevation: 0,
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              'Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            AppFormField(
                readonly: true,
                controller: nameController,
                validator: (value) => Validator.requiredValidator(value),
                inputType: TextInputType.text,
                height: size.height * 0.065,
                width: size.width,
                labelText: "",
                fontSize: 12.sp,

                // controller: viewModel.password,
                fontWeight: FontWeight.w400),
            SizedBox(height: 16.0),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            AppFormField(
                readonly: true,
                controller: emailController,
                validator: (value) => Validator.requiredValidator(value),
                inputType: TextInputType.text,
                height: size.height * 0.065,
                width: size.width,
                labelText: "",
                fontSize: 12.sp,

                // controller: viewModel.password,
                fontWeight: FontWeight.w400),
            Spacer(),
            CustomButton(
              height: 6.h,
              text: "DELETE ACCOUNT",
              textColor: white,
              color: errorRed,
              width: double.infinity,
              onTap: () {
                confirmDialog();
              },
              textfontsize: 14,
            ),
            SizedBox(
              height: 10,
            ),
            isDisable == false
                ? CustomButton(
                    textfontsize: 16,
                    height: 6.h,
                    textColor: white,
                    color: primaryGreen,
                    text: "LOG OUT",
                    onTap: () async {
                      final securedStorageService =
                          ref.read(secureStorageServiceProvider);
                      await securedStorageService.clearStorage();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginView.id, (route) => false);
                    },
                    width: double.infinity,
                  )
                : CustomButton(
                    textfontsize: 16,
                    height: 6.h,
                    textColor: white,
                    color: Colors.blue,
                    text: "UPDATE",
                    onTap: () async {
                      setState(() {
                        isDisable = false;
                      });
                    },
                    width: double.infinity,
                  )
          ],
        ),
      ),
    );
  }

  confirmDialog() {
    showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Delete your Account?'),
          content: const Text(
              '''If you select Delete we will delete your account on our server.

Your app data will also be deleted and you won't be able to retrieve it.

Since this is a security-sensitive operation, you eventually are asked to login before your account can be deleted.'''),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                // Call the delete account function
                await deleteUserAccount();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete().then((value) {
        Navigator.pop(context);

        deleteDocumentsFromBothCollections();
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);

      if (e.code == "requires-recent-login") {
        Navigator.of(context).pop();

        signInDialog();
      } else {
        Navigator.pop(context);
        RoutePage.showErrorSnackbars("${e.message}");
        Logger().e(e);
      }
    } catch (e) {
      Logger().e(e);
      Navigator.pop(context);
      RoutePage.showErrorSnackbars("${e.toString()}");
    }
  }

  void signInDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'SIGN IN',
              style: TextStyle(color: grey),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: grey),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (passwordController.text.isEmpty ||
                      emailController.text.isEmpty) {
                    Navigator.pop(context);
                    RoutePage.showErrorSnackbars("All fields required");
                  } else {
                    await _reauthenticateAndDelete().then((value) async {
                      final securedStorageService =
                          ref.read(secureStorageServiceProvider);
                      await securedStorageService.clearStorage();

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginView.id,
                        (route) => false,
                      );
                    }).catchError((e) {
                      Navigator.pop(context);
                      RoutePage.showErrorSnackbars(e.toString());
                    });
                  }

                  //Navigator.pop(context);
                },
                child: Text('Sign In'),
              ),
            ],
          );
        });
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      String email = emailController.text;
      String password = passwordController.text;

// Create a credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

// Reauthenticate
      await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);

      await FirebaseAuth.instance.currentUser?.delete().then((value) {
        deleteDocumentsFromBothCollections();
      });
    } on FirebaseAuthException catch (e) {
      RoutePage.showErrorSnackbars("${e.message}");
    } catch (e) {
      // Handle exceptions
      Navigator.of(context).pop();

      RoutePage.showErrorSnackbars("${e.toString()}");
    }
  }

  void deleteDocumentsFromBothCollections() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final userDocumentReference =
        firestore.collection(FirebaseCollection.user).doc(emailController.text);
    final surveyDocumentReference = firestore
        .collection(FirebaseCollection.survey)
        .doc(emailController.text);

    firestore.runTransaction((Transaction transaction) async {
      await transaction.delete(userDocumentReference);
      await transaction.delete(surveyDocumentReference);
    }).then((value) async {
      print(
          'Documents with email ${emailController.text} deleted successfully from both collections.');
      //service.setLogout();
      final securedStorageService = ref.read(secureStorageServiceProvider);
      await securedStorageService.clearStorage();
      Navigator.pushNamedAndRemoveUntil(
          context, LoginView.id, (route) => false);
    }).catchError((error) {
      print('Error deleting documents: $error');
    });
  }
}
