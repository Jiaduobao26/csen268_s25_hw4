import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed; // onPressed callback
  final String text; // text

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });

   @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 333,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(101, 85, 143, 1),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}