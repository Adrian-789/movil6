import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderPredictionScreen extends StatefulWidget {
  @override
  _GenderPredictionScreenState createState() => _GenderPredictionScreenState();
}

class _GenderPredictionScreenState extends State<GenderPredictionScreen> {
  TextEditingController _nameController = TextEditingController();
  String _gender = '';
  Color _backgroundColor = Colors.white;

  Future<void> _predictGender() async {
    final name = _nameController.text.trim().toLowerCase();
    if (name.isEmpty) {
      return;
    }

    final apiUrl = 'https://api.genderize.io/?name=$name';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final gender = data['gender'];

        setState(() {
          _gender = gender;
          _backgroundColor = gender == 'male' ? Colors.blue : Colors.pink;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predicción de Género'),
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
              onPressed: _predictGender,
              child: Text('Predecir Género'),
            ),
            SizedBox(height: 16),
            _gender.isNotEmpty
                ? Text(
                    'Género predicho: $_gender',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                : Container(),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
    );
  }
}
