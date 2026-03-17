import 'package:finalproject/info_grab.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {
  final Map<String,dynamic> simulateCardJson={
    'name':'Dark Magician',
    'type':'Normal Monster',
    'desc':'The ultimate wizard in terms of attack and defense.',
  };

  final info=InfoGrab(simulateCardJson);

  test('Get card Name', () {
    expect(info.name,equals('Dark Magician'));
  });

  test('Get card type', () {
    expect(info.type,equals('Normal Monster'));
  });

  test('Get card Description', () {
    expect(info.desc, equals("The ultimate wizard in terms of attack and defense."));
  });

}