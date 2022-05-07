import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class CustomAnimatedText extends StatelessWidget {
  final String text;
  final int? duration;

  const CustomAnimatedText(
      {Key? key, required this.text, this.duration = 300})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(text,
            speed: Duration(milliseconds: duration!),
            textStyle: const TextStyle(
              fontFamily: 'Agne',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
      ],
      repeatForever: true,
    );
  }
}
