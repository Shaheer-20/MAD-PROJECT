import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/pdf_view_screen.dart';
import 'screens/excel_view_screen.dart'; // Add this import

void main() {
  runApp(const DocumentReaderApp());
}

class DocumentReaderApp extends StatelessWidget {
  const DocumentReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/pdf': (context) => PDFViewScreen(),
        '/excel': (context) => const ExcelViewScreen(
              filePath: 'excel/excel.dart',
            ), // Correct the name here
      },
    );
  }
}
