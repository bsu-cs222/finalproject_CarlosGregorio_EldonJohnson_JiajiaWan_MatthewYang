import 'dart:io';

import 'package:finalproject/info_grab.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  group('CardApiService Test', () {
    test('network request successful', () async {
      final mockClient = MockClient((request) async {
        final jsonResponse = '''
        {
          "data": [
            {
              "name": "Dark Magician",
              "type": "Normal Monster",
              "desc": "The ultimate wizard in terms of attack and defense."
            }
          ]
        }
        ''';
        return http.Response(jsonResponse, 200);
      });

      final apiService = CardApiService(client: mockClient);
      final response = await apiService.fetchCard('Dark Magician');

      expect(response.isSuccess, isTrue);
      expect(response.data, isNotNull);
      expect(response.data?.name, equals('Dark Magician'));
    });

    test('card not found', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '{"error": "No card matching your query was found in the database."}',
          400,
        );
      });

      final apiService = CardApiService(client: mockClient);
      final response = await apiService.fetchCard('UnknownCard111');

      expect(response.isSuccess, isFalse);
      expect(response.data, isNull);
      expect(response.errorMessage, contains('not found'));
    });

    test('network error', () async {
      final mockClient = MockClient((request) async {
        throw const SocketException('Failed application');
      });

      final apiService = CardApiService(client: mockClient);
      final response = await apiService.fetchCard('Dark Magician');

      expect(response.isSuccess, isFalse);
      expect(response.data, isNull);
      expect(response.errorMessage, equals('Network connection failed.'));
    });

    test('case insensitive', () async {
      final mockClient = MockClient((request) async {
        final jsonResponse = '''
    {
      "data": [
        {
          "name": "Dark Magician",
          "type": "Normal Monster",
          "desc": "The ultimate wizard in terms of attack and defense."
        }
      ]
    }
    ''';
        return http.Response(jsonResponse, 200);
      });

      final apiService = CardApiService(client: mockClient);

      final response = await apiService.fetchCard('dArK mAgIcIaN');
      expect(response.isSuccess, isTrue);
      expect(response.data?.name, equals('Dark Magician'));
    });
  });
}
