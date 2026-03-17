import 'package:flutter/material.dart';
import 'searchPage.dart';

void main() {
  runApp(const YuGiOhApp());
}

class YuGiOhApp extends StatelessWidget {
  const YuGiOhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(),
    );
  }
}
