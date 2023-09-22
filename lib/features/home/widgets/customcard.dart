import 'package:flutter/material.dart';

class JourneyModeCards extends StatelessWidget {
  final Image image;
  final String mode;
  final String desc;
  final bool select;

  const JourneyModeCards(
      {super.key,
      required this.image,
      required this.mode,
      required this.desc,
      this.select = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {},
        leading: image,
        title: Text(
          mode,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          desc,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
