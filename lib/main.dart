import 'package:flutter/material.dart';
import 'qr_code_scanner_page.dart';
import 'history_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QR Code Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QRCodeScannerPage(),
      routes: {
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
