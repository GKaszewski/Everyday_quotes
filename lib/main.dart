import 'package:flutter/material.dart';
import 'package:everyday_quotes/home.dart';

void main() {
  runApp(new EverydayQuotesApp());
}

class EverydayQuotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Everyday quotes",
      home: new HomeScreen(),
    );
  }
}

