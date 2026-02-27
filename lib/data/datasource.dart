
import 'dart:convert';

import 'package:advicely/data/model.dart';
import 'package:http/http.dart' as http;

/// génère un conseil et retourne le texte traduit en français
Future<Conseil> genererConseil() async {
  final client = http.Client();
  final uri = "https://api.api-ninjas.com/v1/advice";
  final cle = "EMmW4203J9K2hpSlRYXmLZn6I6mc4sRN7sWL2syz";
  final reponse = await client.get(Uri.parse(uri), headers: {"X-Api-Key": cle});
  final json =
      jsonDecode(utf8.decode(reponse.bodyBytes))
          as Map; // L'api ne retourne une liste dans ce cas présent.

  // récupérer le texte en anglais puis traduire
  final anglais = json["advice"] as String;
  final francais = await _translateToFrench(anglais);
  json["advice"] = francais;

  return Conseil.fromJSON(json);
}

/// Appel simple à un service de traduction public (MyMemory)
Future<String> _translateToFrench(String text) async {
  try {
    final uri = Uri.parse(
      'https://api.mymemory.translated.net/get?langpair=en|fr&q=${Uri.encodeComponent(text)}',
    );
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final map = jsonDecode(res.body) as Map;
      final translated = map['responseData']?['translatedText'] as String?;
      if (translated != null && translated.isNotEmpty) {
        return translated;
      }
    }
  } catch (_) {}
  // en cas d'erreur on retourne le texte original
  return text;
}
