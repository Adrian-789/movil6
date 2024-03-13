import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi App'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Página Principal'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Predicción de Género'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/gender_prediction');
              },
            ),
            ListTile(
              title: Text('Predicción de Edad'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/age_prediction');
              },
            ),
            ListTile(
              title: Text('Universidades'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/universities');
              },
            ),
            ListTile(
              title: Text('Clima'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/weather');
              },
            ),
            ListTile(
              title: Text('Noticias'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/news');
              },
            ),
            ListTile(
              title: Text('Acerca de'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/caja-de-herramientas.jpg',
              width: 200,
              height: 200,
            ),
            Text('Contenido de la página principal'),
          ],
        ),
      ),
    );
  }
}
