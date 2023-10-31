// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PageItem extends StatelessWidget {
  const PageItem({
    super.key,
    required this.item,
  });
  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.st,
        children: [
          Spacer(),
          Center(
            child: item['image'].toString().contains('lotties')
                ? Lottie.asset(
                    item['image'].toString(),
                  )
                : Image.asset(
                    item['image'].toString(),
                    // width: 200.0,
                    // height: 200.0,
                    fit: BoxFit.contain,
                  ),
          ),
          SizedBox(height: 16.0),
          Text(
            item['text'].toString(),
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
