import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  static const id = "/username";
  UserProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('User Profile'),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Text(
              'Name:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'Ashraf Khan',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none, // Hide the default border
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(10.0), // Border radius
              ),
              child: TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: 'AshrafKhan@gmail.com',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  border: InputBorder.none, // Hide the default border
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
