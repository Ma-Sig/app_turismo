import 'package:flutter/material.dart';
import '../main.dart'; // Importa el themeNotifier

class ConfigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuraciones')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Modo Oscuro'),
            value: themeNotifier.value == ThemeMode.dark,
            onChanged: (val) {
              themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
            },
            secondary: Icon(Icons.dark_mode),
          ),
          ListTile(leading: Icon(Icons.logout), title: Text('Logout')),
          ListTile(leading: Icon(Icons.feedback), title: Text('Feedback')),
          ListTile(leading: Icon(Icons.info), title: Text('Ayuda')),
        ],
      ),
    );
  }
}