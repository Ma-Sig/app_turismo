import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Perfil')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 40, backgroundColor: Colors.grey.shade300),
            Text('Usuario'),
            TextField(decoration: InputDecoration(labelText: 'Nombre')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            SizedBox(height: 20),
            Text('Mis favoritos'),
            ListTile(title: Text('Museo Moderno')),
            ListTile(title: Text('Catedral Vieja')),
          ],
        ),
      ),
    );
  }
}