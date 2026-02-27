
import 'package:advicely/data/model.dart';
import 'package:advicely/widgets/copie_button.dart';
import 'package:advicely/widgets/generer_button.dart';
import 'package:advicely/widgets/panneau_central.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:advicely/data/datasource.dart' as datasource;

class ConseilPage extends StatefulWidget {
  @override
  State<ConseilPage> createState() => _ConseilPageState();
}

class _ConseilPageState extends State<ConseilPage> {
  List <Conseil> conseils = [];

  Future <void> _chargerConseils() async {
    try{
      Conseil conseil = await datasource.genererConseil();
      setState(() {
        conseils.add(conseil);

      });
    }catch (e){
      print ("Erreur chargement conseils : $e");
    }
  }
  @override
  void initState(){
    super.initState();
    _chargerConseils();
  }
  @override
  Widget build(BuildContext context) {
    final panneauCentral = PanneauCentral(future: datasource.genererConseil());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5A7D75),
        title: Text("Advicely", style: GoogleFonts.inter(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        constraints:BoxConstraints.expand(),
        color:Color(0xffedffe4),
        padding:EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
          
            children: [
              Text(
                "Conseil de vie",
                textAlign: TextAlign.center,
                style: GoogleFonts.enriqueta(
                  color: Color(0xFF2E554C),
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: SvgPicture.asset(
                  "assets/img/image.svg",
                  height: 86,
                  width: 90,
                  colorFilter: ColorFilter.mode(
                    Color(0xFF2E554C),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(height: 30),
              panneauCentral,
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: GenererButton(
                      onPressed: () {
                        setState(() {}); //actualise la page
                      },
                    ),
                  ),
                  SizedBox(width: 30),
                  CopieButton(
                    onPressed: () async {
                      try {
                        await FlutterClipboard.copy(panneauCentral.texte);
                      } on ClipboardException catch (e) {}
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