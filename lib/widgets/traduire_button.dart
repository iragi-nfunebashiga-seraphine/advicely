import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TraduireButton extends StatelessWidget {
  final void Function() onPressed;

  const TraduireButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: const Color(0xFF766826), // même couleur que Generer
      height: 80,
      child: Text(
        "Traduction en Francais",
        style: GoogleFonts.inter(color: Colors.white, fontSize: 24),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
