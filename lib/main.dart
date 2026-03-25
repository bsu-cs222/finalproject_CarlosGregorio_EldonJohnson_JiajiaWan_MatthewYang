import 'package:flutter/material.dart';

import 'card.dart';

void main() {
  runApp(const YuGiOhApp());
}

class YuGiOhApp extends StatelessWidget {
  const YuGiOhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SearchPage());
  }
}
