import 'package:advicely/data/model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PanneauCentral extends StatelessWidget {
  final Future future;
  String texte = "";

  PanneauCentral({super.key, required this.future});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: EdgeInsets.all(20),
      child: FutureBuilder(
        future: future,
        builder: (context, asyncSnapshot) {
          texte = "";
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              ),
            );
          } else if (asyncSnapshot.hasData) {
            final conseil = asyncSnapshot.data as Conseil;
            texte = conseil.conseilTexte;
            return Center(
              child: Text(
                texte,
                style: GoogleFonts.enriqueta(color: Colors.white, fontSize: 32),
              ),
            );
          } else if (asyncSnapshot.hasError) {
            return Center(
              child: Text(
                "Erreur: une erreur s'est produite lors du chargement",
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 246, 176, 171),
                  fontSize: 24,
                ),
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(backgroundColor: Colors.white),
              ),
            );
          }
        },
      ),
      decoration: BoxDecoration(
        color: Color(0xFF5A7D75),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(100),
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}