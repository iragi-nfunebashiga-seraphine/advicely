class Conseil {
  final String conseilTexte;
  Conseil({this.conseilTexte = ""});

  factory Conseil.fromJSON(Map<dynamic,dynamic > json){
    return Conseil(conseilTexte: json["advice"] as  String);
  }
}