import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenererButton extends StatelessWidget {
  final void Function() onPressed;
  const GenererButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Color(0xFF766826),
      height: 80,
      child: Text(
        "generer",
        style: GoogleFonts.inter(color: Colors.white, fontSize: 24),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
  
}