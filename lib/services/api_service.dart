import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflex/models/movie_detail_model.dart';
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
      print('nowPlaying: ${movies.length}');
      for (var m in movies) {
        movieInstances.add(MovieModel.fromJson(m));
      }
      return movieInstances;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<MovieDetailModel> getMovieDetail(String id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/popular");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      print('popular: ${movies.length}');
      for (var m in movies) {
        movieInstances.add(MovieModel.fromJson(m));
      }
      return movieInstances;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<MovieModel>> getComingSoon() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/coming-soon");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      print('comingSoon: ${movies.length}');
      for (var m in movies) {
        movieInstances.add(MovieModel.fromJson(m));
      }
      return movieInstances;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
