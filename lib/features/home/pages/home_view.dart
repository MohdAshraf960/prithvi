// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';

import 'package:prithvi/config/config.dart';

import 'package:prithvi/core/core.dart';
import 'package:prithvi/features/home/widgets/page_item.dart';

class Home extends StatefulWidget {
  static const id = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController =
      PageController(); // Define _pageController here
  int _currentPage = 0;

  final List<Map<String, String>> data = [
    {
      'image':
          "https://firebasestorage.googleapis.com/v0/b/prithvi-70646.appspot.com/o/lottie%2Fonboard.json?alt=media&token=5499932c-ed88-4f90-99b3-654099955db7&_gl=1*7y6vun*_ga*MTcyMDYzOTI3Mi4xNjgzNzg3Nzc0*_ga_CW55HF8NVT*MTY5NzQ2Nzg0Mi4xMTMuMS4xNjk3NDY4NzE2LjYwLjAuMA..",
      'text': 'We are thrilled to welcome \nyou to the Prithivi community',
    },
    {
      'image': Assets.second,
      'text':
          'Conveniently track the environmental \nimpact of your daily activities such as food,\ndaily commute,travel and consumption',
    },
    {
      'image': Assets.third,
      'text': 'Get easy suggestion to reduce your impact',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return PageItem(
                  item: data[index],
                );
              },
            ),
          ),
          DotsIndicator(
            dotsCount: data.length,
            position: _currentPage,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive dot color
              activeColor: primaryGreen, // Active dot color
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
