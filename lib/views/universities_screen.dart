import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniversitiesScreen extends StatefulWidget {
  @override
  _UniversitiesScreenState createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  TextEditingController _countryController = TextEditingController();
  List<University> _universities = [];

  Future<void> _fetchUniversities() async {
    final country = _countryController.text.trim().toLowerCase();
    if (country.isEmpty) {
      return;
    }

    final apiUrl = 'http://universities.hipolabs.com/search?country=$country';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        final universities = data.map((uni) => University.fromJson(uni)).toList();

        setState(() {
          _universities = universities;
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
        title: Text('Universidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _countryController,
              decoration: InputDecoration(labelText: 'País (en inglés)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchUniversities,
              child: Text('Buscar Universidades'),
            ),
            SizedBox(height: 16),
            _universities.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _universities
                            .map(
                              (uni) => ListTile(
                                title: Text(uni.name),
                                subtitle: Text('Dominio: ${uni.domain}\nEnlace: ${uni.webPage}'),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class University {
  final String name;
  final String domain;
  final String webPage;

  University({
    required this.name,
    required this.domain,
    required this.webPage,
  });

  factory University.fromJson(Map<String, dynamic> json) {
    return University(
      name: json['name'] ?? '',
      domain: json['domains']?.isNotEmpty == true ? json['domains'][0] : '',
      webPage: json['web_pages']?.isNotEmpty == true ? json['web_pages'][0] : '',
    );
  }
}

