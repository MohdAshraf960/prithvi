import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Category_View extends StatefulWidget {
  static const id = "/category";
  const Category_View({super.key});

  @override
  State<Category_View> createState() => _Category_ViewState();
}

class _Category_ViewState extends State<Category_View> {
  double _value = 25;
  double _value1 = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Text(
                'START WITH A QUICK CARBON FOOTPRINT ESTIMATE',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade900),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '1. Where do you live?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue.shade900),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Please enter city or zipcode'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '2. How many people live in your household?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue.shade900),
            ),
            SfSlider(
              value: _value,
              min: 10,
              max: 100,
              interval: 15,
              showTicks: true,
              showLabels: true,
              // enableTooltip: true,
              onChanged: (dynamic value) {
                setState(
                  () {
                    _value = value;
                  },
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '3. What is your gross annual household income?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue.shade900),
            ),
            SfSlider(
              value: _value1,
              min: 10,
              max: 100,
              interval: 15,
              showTicks: true,
              showLabels: true,
              // enableTooltip: true,
              onChanged: (dynamic value) {
                setState(
                  () {
                    _value1 = value;
                  },
                );
              },
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(color: Colors.green),
              child: Center(
                child: Text(
                  'REFINE YOUR ESTIMATE',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
