import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final String apiKey = '278505134812106d48b772caa2f80b9d'; // Reemplaza con tu clave de API de OpenWeatherMap
  final String city = 'Santo Domingo'; // Cambia a la ciudad que desees

  String weatherDescription = '';
  double temperature = 0.0;

  Future<void> _fetchWeather() async {
    final apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final description = data['weather'][0]['description'];
        final temp = data['main']['temp'];

        setState(() {
          weatherDescription = description;
          temperature = temp;
        });
      } else {
        // Manejar respuesta de error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar error de red
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima en RD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Obtener Clima'),
            ),
            SizedBox(height: 16),
            weatherDescription.isNotEmpty
                ? Text(
                    'Descripción: $weatherDescription\nTemperatura: $temperature °C',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

