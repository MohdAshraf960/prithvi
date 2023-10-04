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
      'image': Assets.first,
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   // title: Text('Home'),

      //   elevation: 0,
      //   actions: [
      //     TextButton(
      //       onPressed: () {},
      //       child: Text(
      //         "SKIP",
      //         style: TextStyle(fontSize: 16, color: grey),
      //       ),
      //     ),
      //   ],
      // ),
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
          // if (_currentPage == 2)
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: CustomButton(
          //         height: 50,
          //         text: "Calculate your carbon footprint".toUpperCase(),
          //         textColor: white,
          //         color: primaryGreen,
          //         width: double.infinity,
          //         onTap: () {

          //         },
          //         textfontsize: 16),
          //   ),
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
