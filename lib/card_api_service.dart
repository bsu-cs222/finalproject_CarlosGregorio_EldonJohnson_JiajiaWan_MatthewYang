import 'dart:convert';

import 'package:http/http.dart' as http;

import 'card.dart';
import 'server_response.dart';

class CardApiService {
  final http.Client client;

  CardApiService({required this.client});

  Future<ServerResponse> fetchCard(String name) async {
    final url = Uri.parse(
      'https://db.ygoprodeck.com/api/v7/cardinfo.php?name=$name',
    );

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
          final card = Card.fromJson(jsonData['data'][0]);
          return ServerResponse(isSuccess: true, data: card);
        }

        if (jsonData['data'] == null || jsonData['data'].isEmpty) {
          return ServerResponse(
            isSuccess: false,
            errorMessage: 'Card not found',
          );
        }
      }

      if (response.statusCode == 400 || response.statusCode == 404) {
        return ServerResponse(isSuccess: false, errorMessage: 'Card not found');
      }

      return ServerResponse(
        isSuccess: false,
        errorMessage: 'Network connection failed.',
      );
    } catch (e) {
      return ServerResponse(
        isSuccess: false,
        errorMessage: 'Network connection failed.',
      );
    }
  }
}
