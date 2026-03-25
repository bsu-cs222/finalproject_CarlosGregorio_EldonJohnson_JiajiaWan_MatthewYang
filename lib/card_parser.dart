import 'dart:convert';

import 'card.dart';
import 'server_response.dart';

class CardParser {
  static ServerResponse parseCardData(String responseBody) {
    try {
      final jsonData = jsonDecode(responseBody);

      if (jsonData['data'] != null && jsonData['data'].isNotEmpty) {
        final card = Card.fromJson(jsonData['data'][0]);
        return ServerResponse(isSuccess: true, data: card);
      } else if (jsonData['data'] != null && jsonData['data'].NotEmpty) {
        return ServerResponse(
          isSuccess: false,
          errorMessage: 'The requested card does not exist.',
        );
      } else if (jsonData['data'] == null) {
        return ServerResponse(
          isSuccess: false,
          errorMessage: 'Invalid API response:missing data failed.',
        );
      }
    } catch (e) {
      return ServerResponse(
        isSuccess: false,
        errorMessage: 'Failed to parse server data',
      );
    }
  }
}
