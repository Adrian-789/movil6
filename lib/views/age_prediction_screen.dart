import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgePredictionScreen extends StatefulWidget {
  @override
  _AgePredictionScreenState createState() => _AgePredictionScreenState();
}

class _AgePredictionScreenState extends State<AgePredictionScreen> {
  TextEditingController _nameController = TextEditingController();
  int _age = 0;
  String _ageGroup = '';
  String _imageAsset = '';

  Future<void> _predictAge() async {
    final name = _nameController.text.trim().toLowerCase();
    if (name.isEmpty) {
      return;
    }

    final apiUrl = 'https://api.agify.io/?name=$name';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final predictedAge = data['age'] as int;

        setState(() {
          _age = predictedAge;

          if (_age < 18) {
            _ageGroup = 'Joven';
            _imageAsset = 'assets/joven.jpg';
          } else if (_age < 65) {
            _ageGroup = 'Adulto';
            _imageAsset = 'assets/adulto.jpg';
          } else {
            _ageGroup = 'Anciano';
            _imageAsset = 'assets/anciano.jpg';
          }
        });
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Error: $e');
    }
  }

  void _resetPrediction() {
    setState(() {
      _nameController.text = '';
      _age = 0;
      _ageGroup = '';
      _imageAsset = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _predictAge,
              child: Text('Predecir Edad'),
            ),
            SizedBox(height: 16),
            _age > 0
                ? Column(
                    children: [
                      Text(
                        'Edad estimada: $_age años',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Grupo de edad: $_ageGroup',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Image.asset(
                        _imageAsset,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _resetPrediction,
                        child: Text('Ingresar otro nombre'),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
