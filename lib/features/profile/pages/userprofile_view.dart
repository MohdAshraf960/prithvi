import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sizer/sizer.dart';

import '../../auth/widgets/textformfield.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  static const id = "/username";

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  // UserProfileScreen();
  SharedPreferencesService service = SharedPreferencesService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch user data from SharedPreferences when the widget initializes
    getUser();
  }

  // Method to fetch user data from SharedPreferences
  void getUser() async {
    final getuser = await SharedPreferences.getInstance().then((prefs) {
      return prefs.getString(SharedPreferencesService.userKey);
    });

    if (getuser != null) {
      final userModel = UserModel.fromJson(getuser);
      setState(() {
        nameController.text = userModel.name
            .toString(); // Update the user variable with the user data
        emailController.text = userModel.email.toString();
      });
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
            isDisable == false
                ? CustomButton(
                    textfontsize: 16,
                    height: 6.h,
                    textColor: white,
                    color: primaryGreen,
                    text: "LOG OUT",
                    onTap: () async {
                      service.setLogout();
                      Navigator.pushNamedAndRemoveUntil(
                          context, Login.id, (route) => false);
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
                      service.getUser();
                    },
                    width: double.infinity,
                  )
          ],
        ),
      ),
    );
  }
}
