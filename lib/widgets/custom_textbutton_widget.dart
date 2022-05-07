import 'package:flutter/material.dart';

class CustomTextButtonWidget extends StatelessWidget {
  final Function method;
  final String text;
  const CustomTextButtonWidget(
      {Key? key, required this.method, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => method(),
          child: Text(
            text,
            style: const TextStyle(
              color: Color.fromRGBO(156, 39, 176, 1),
              fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    );
  }
}
