import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuraciones')),
      body: ListView(
        children: [
          ListTile(leading: Icon(Icons.dark_mode), title: Text('Modo Oscuro')),
          ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
          ListTile(leading: Icon(Icons.feedback), title: Text('Feedback')),
          ListTile(leading: Icon(Icons.info), title: Text('Ayuda')),
        ],
      ),
    );
  }
}