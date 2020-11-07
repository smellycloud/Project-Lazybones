import 'package:flutter/material.dart';

import 'screens/homescreen.dart';

void main() {
  runApp(Bleh());
}

class Bleh extends StatefulWidget {
  @override
  _BlehState createState() => _BlehState();
}

class _BlehState extends State<Bleh> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Homescreen(),
    );
  }
}
