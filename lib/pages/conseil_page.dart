import 'package:advicely/widgets/copie_button.dart';
import 'package:advicely/widgets/generer_button.dart';
import 'package:advicely/widgets/traduire_button.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:advicely/data/datasource.dart' as datasource;

class ConseilPage extends StatefulWidget {
  @override
  State<ConseilPage> createState() => _ConseilPageState();
}

class _ConseilPageState extends State<ConseilPage> {
  String texte = "";
  String texteTraduit = "";
  bool chargement = false;

  Future<void> generer() async {
    setState(() {
      chargement = true;
      texteTraduit = "";
    });

    final conseil = await datasource.genererConseil();

    setState(() {
      texte = conseil.conseilTexte;
      chargement = false;
    });
  }

  Future<void> traduire() async {
    if (texte.isEmpty) return;

    setState(() {
      chargement = true;
    });

    try {
      final traduction = await datasource.traduireEnFrancais(texte);

      print("TRADUCTION OK : $traduction");

      setState(() {
        texteTraduit = traduction;
      });
    } catch (e) {
      print("ERREUR TRADUCTION : $e");
      setState(() {
        texteTraduit = "Erreur lors de la traduction";
      });
    }

    setState(() {
      chargement = false;
    });
  }

  @override
  void initState() {
    super.initState();
    generer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5A7D75),
        title: Text("Advicely", style: GoogleFonts.inter(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        color: const Color(0xFFEDFFE4),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Conseil de vie",
                textAlign: TextAlign.center,
                style: GoogleFonts.enriqueta(
                  color: const Color(0xFF2E554C),
                  fontSize: 32,
                ),
              ),

              const SizedBox(height: 30),
              Center(
                child: SvgPicture.asset(
                  "assets/img/image.svg",
                  height: 86,
                  width: 90,
                  colorFilter: ColorFilter.mode(Color(0xff2e554c),BlendMode.srcIn,
                ),
              ),
              ),
              const SizedBox(height: 30),

              Container(
                height: 250,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF5A7D75),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(100),
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: chargement
                    ? const Center(child: CircularProgressIndicator())
                    : Center(
                        child: Text(
                          texteTraduit.isNotEmpty ? texteTraduit : texte,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.enriqueta(
                            color: Colors.white,
                            fontSize: 28,
                          ),
                        ),
                      ),
              ),

              const SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: GenererButton(onPressed: generer)),

                  const SizedBox(width: 30),

                  Expanded(child: TraduireButton(onPressed: traduire)),

                  const SizedBox(width: 30),

                  CopieButton(
                    onPressed: () async {
                      try {
                        await FlutterClipboard.copy(
                          texteTraduit.isNotEmpty ? texteTraduit : texte,
                        );
                      } on ClipboardException {}
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
