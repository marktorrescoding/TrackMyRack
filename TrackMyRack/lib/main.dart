import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ClimbingApp());
}

class ClimbingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Climbing App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
