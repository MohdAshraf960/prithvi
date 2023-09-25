import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:prithvi/core/colors/colors.dart';

import 'package:prithvi/features/category/pages/category_view.dart';
import 'package:prithvi/features/home/pages/home_view.dart';
import 'package:prithvi/features/profile/pages/userprofile_view.dart';
import 'package:sizer/sizer.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const id = "/bottombar";
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  final List<String> image =
      List.generate(3, (index) => "assets/images/bottom${index + 1}.png");
  List<String> label = ["Home", "Category", "Profile"];
  List<IconData> icon = [Icons.home, Icons.category, Icons.person];

  int selectedIndex = 0;

  getBody() {
    switch (selectedIndex) {
      case 0:
        return Home();
      case 1:
        return CategoryView();
      case 2:
        return UserProfileScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: white,
          height: 10.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < image.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = i;
                    });
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                          height: 35,
                          width: 18.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            icon[i],
                            color:
                                selectedIndex == i ? primaryGreen : grey3Color,
                          )),
                      Text(
                        label[i],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: selectedIndex == i ? primaryGreen : grey3Color,
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
      body: getBody(),
    );
  }
}
