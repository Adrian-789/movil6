import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String apiKey = '3030a007fb224a45a01b77a9e1971bd4';
  final String newsSource = 'diario-libre';
  List<Article> _articles = [];

  Future<void> _fetchNews() async {
    final apiUrl = 'https://newsapi.org/v2/top-headlines?sources=$newsSource&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = (data['articles'] as List).map((article) => Article.fromJson(article)).toList();

        setState(() {
          _articles = articles;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('No se pudo abrir el enlace: $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchNews,
              child: Text('Obtener Noticias'),
            ),
            SizedBox(height: 16),
            _articles.isNotEmpty
                ? Column(
                    children: _articles
                        .map(
                          (article) => ListTile(
                            title: Text(article.title),
                            subtitle: Text(article.description),
                            onTap: () {
                              _launchURL(article.url); // Utiliza la URL específica del artículo
                            },
                          ),
                        )
                        .toList(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String description;
  final String url;

  Article({
    required this.title,
    required this.description,
    required this.url,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
