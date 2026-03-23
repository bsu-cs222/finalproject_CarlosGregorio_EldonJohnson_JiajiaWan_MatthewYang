import 'package:flutter_test/flutter_test.dart';

import '../lib/card.dart';

void main() {
  group('Card Domain Model Test', () {
    test('Complete JSON', () {
      final Map<String, dynamic> completeJson = {
        'name': 'Dark Magician',
        'type': 'Normal Monster',
        'desc': 'The ultimate wizard in terms of attack and defense.',
      };

      final card = Card.fromJson(completeJson);
      expect(card.name, equals('Dark Magician'));
      expect(card.type, equals('Normal Monster'));
      expect(
        card.desc,
        equals('The ultimate wizard in terms of attack and defense.'),
      );
    });

    test('Incompleted JSON data', () {
      final Map<String, dynamic> incompleteJson = {'name': 'Dark Magician'};

      final card = Card.fromJson(incompleteJson);
      expect(card.name, equals('Dark Magician'));
      expect(card.type, equals(''));
      expect(card.desc, equals(''));
    });

    test('Empty JSON data', () {
      final Map<String, dynamic> emptyJson = {};

      final card = Card.fromJson(emptyJson);
      expect(card.name, equals(''));
      expect(card.type, equals(''));
      expect(card.desc, equals(''));
    });
  });
}
