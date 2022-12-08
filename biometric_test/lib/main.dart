import 'package:flutter/material.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fingerprint_test',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeView(),
    );
  }
}
