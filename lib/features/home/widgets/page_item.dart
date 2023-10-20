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
            child: item['image'].toString().contains('https')
                ? Lottie.network(
                    "https://firebasestorage.googleapis.com/v0/b/prithvi-70646.appspot.com/o/lottie%2Fonboard.json?alt=media&token=5499932c-ed88-4f90-99b3-654099955db7&_gl=1*7y6vun*_ga*MTcyMDYzOTI3Mi4xNjgzNzg3Nzc0*_ga_CW55HF8NVT*MTY5NzQ2Nzg0Mi4xMTMuMS4xNjk3NDY4NzE2LjYwLjAuMA..")
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
