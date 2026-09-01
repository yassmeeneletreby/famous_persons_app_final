import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';

class ApiService {
  static const String _apiKey = '2dfe23358236069710a379edd4c65a6b';
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<Person>> getPopularPersons() async {
    final uri = Uri.parse(
      '$_baseUrl/person/popular?api_key=$_apiKey',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load persons (${response.statusCode})');
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    final List<dynamic> results = data['results'] as List<dynamic>? ?? [];

    return results
        .map((item) => Person.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$_imageBaseUrl$path';
  }
}
