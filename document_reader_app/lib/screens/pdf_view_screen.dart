import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';

class PDFViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String filePath =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: SfPdfViewer.file(
        File(filePath),
      ),
    );
  }
}
