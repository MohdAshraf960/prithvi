
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prithvi/features/auth/pages/login_view.dart';
import 'package:prithvi/features/home/pages/home_view.dart';
import 'package:sizer/sizer.dart';

class BottomBar extends ConsumerStatefulWidget {
  static const id = "/bottombar";
  const BottomBar({super.key});

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  final List<String> image =
      List.generate(3, (index) => "Assets/Images/bottom${index + 1}.png");
  List<String> label = ["Home", "Category", "Profile"];

  int selectedIndex = 1;

  getBody() {
    switch (selectedIndex) {
      case 0:
        return  Home();
      case 1:
        return Login();
      case 2:
        return  Login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.purple,
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
                            color: selectedIndex == i
                                ? Colors.green
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child:
                         Image.asset(
                          image[i],
                          height: 20,
                          width: 30,
                        ),
                      ),
                      Text(
                        label[i],
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent),
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
