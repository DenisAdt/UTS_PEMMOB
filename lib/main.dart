import 'package:flutter/material.dart';
import 'presentation/pages/base_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketplace Bahan Pangan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BasePage(),
    );
  }
}
