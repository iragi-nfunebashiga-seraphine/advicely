import 'package:flutter/material.dart';

class CopieButton extends StatelessWidget {
  final void Function() onPressed;
  const CopieButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      height: 80,
      color: Color(0xFF63AC9B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Icon(Icons.copy, color: Colors.white),
    );
  }
}

