import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Reader'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => pickFile(context, 'pdf'),
              child: const Text('Pick PDF File'),
            ),
            ElevatedButton(
              onPressed: () => pickFile(context, 'excel'),
              child: const Text('Pick Excel File'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickFile(BuildContext context, String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path!;
      if (type == 'pdf') {
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/pdf', arguments: filePath);
      } else if (type == 'excel') {
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/excel', arguments: filePath);
      }
    }
  }
}
