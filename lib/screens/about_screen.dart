import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sobre')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Aplicación turística de ejemplo con Flutter.', style: TextStyle(fontSize: 18)),
          Divider(),
          ListTile(title: Text('Versión'), subtitle: Text('1.0.0')),
          ListTile(title: Text('Desarrollador'), subtitle: Text('Tu Nombre')),
          ListTile(title: Text('Contacto'), subtitle: Text('correo@ejemplo.com')),
        ],
      ),
    );
  }
}
