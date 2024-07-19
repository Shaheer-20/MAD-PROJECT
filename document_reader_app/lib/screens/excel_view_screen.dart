import 'dart:io';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';

class ExcelViewScreen extends StatelessWidget {
  final String filePath;
  const ExcelViewScreen({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel Viewer'),
      ),
      body: FutureBuilder<List<Widget>>(
        future: _loadExcel(filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading Excel file'));
          } else {
            final data = snapshot.data!;
            return ListView(children: data);
          }
        },
      ),
    );
  }

  Future<List<Widget>> _loadExcel(String filePath) async {
    final fileBytes = await File(filePath).readAsBytes();
    final excel = Excel.decodeBytes(fileBytes);

    List<Widget> widgets = [];
    for (var table in excel.tables.keys) {
      widgets.add(Text('Table: $table'));
      widgets.addAll(excel.tables[table]!.rows.map((row) {
        return Text(
            row.map((cell) => cell?.value?.toString() ?? '').join(' | '));
      }).toList());
    }
    return widgets;
  }
}
