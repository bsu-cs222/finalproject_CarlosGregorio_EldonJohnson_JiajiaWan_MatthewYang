import 'dart:convert';

import 'package:http/http.dart' as http;

class InfoGrab {
  final String name;
  final String type;
  final String desc;

  InfoGrab(Map<String, dynamic> cardJson)
    : name = cardJson['name'],
      type = cardJson['type'],
      desc = cardJson['desc'];

  static Future<InfoGrab?> fetchCard(String cardName) async {
    final url = Uri.parse(
      'https://db.ygoprodeck.com/api/v7/cardinfo.php?name=${Uri.encodeComponent(cardName)}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
        return InfoGrab(jsonData['data'][0]);
      }
      if (jsonData['data'] == null || jsonData['data'].isEmpty) {
        return null;
      }
    }
    if (response.statusCode != 200) {
      return null;
    }
  }
}
