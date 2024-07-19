import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Document Reader',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text('PDF'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/pdf');
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: Text('Excel'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/excel');
            },
          ),
        ],
      ),
    );
  }
}
