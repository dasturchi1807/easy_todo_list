import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow
        ),
        child: Text(text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
        ),
    );
  }
}
