import 'package:flutter/material.dart';

class CustomTitleWidget extends StatelessWidget {
  final String text;
  const CustomTitleWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontFamily: 'Agne', fontSize: 50, fontWeight: FontWeight.bold),
    );
  }
}
