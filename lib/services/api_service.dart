import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflex/models/movie_model.dart';

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String nowPlaying = "now-playing";

  static Future<List<MovieModel>> getNowPlaying() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/$nowPlaying");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var m in movies) {
        movieInstances.add(MovieModel.fromJson(m));
        print(m['title']);
      }
      return movieInstances;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
