import 'package:flutter/material.dart';
import 'pages/NamePage.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Print Bill',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: NamePage(),
    );
  }
}
