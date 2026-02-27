import 'dart:convert';

import 'package:advicely/data/model.dart';
import 'package:http/http.dart' as http;

Future<Conseil> genererConseil() async {
  final client = http.Client();
  final uri = "https://api.api-ninjas.com/v1/advice";
  final cle = "EMmW4203J9K2hpSlRYXmLZn6I6mc4sRN7sWL2syz";
  final reponse = await client.get(Uri.parse(uri), headers: {"X-Api-Key": cle});
  final json =
      jsonDecode(utf8.decode(reponse.bodyBytes))
          as Map; //L'api ne retourne pas une liste dans ce cas present

  return Conseil.fromJSON(json);
}

Future<String> traduireEnFrancais(String texte) async {
  final query = Uri.encodeComponent(texte);

  final uri = Uri.parse(
    "https://api.mymemory.translated.net/get?q=$query&langpair=en|fr",
  );

  final reponse = await http.get(uri);

  if (reponse.statusCode == 200) {
    final json = jsonDecode(reponse.body);
    return json["responseData"]["translatedText"];
  } else {
    throw Exception("Erreur traduction");
  }
}
