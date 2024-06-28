import 'package:flutter/material.dart';
import 'kontak_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kontak',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const KontakPage(),
    );
  }
}
