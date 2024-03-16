class MovieDetailModel {
  bool adult;
  String backdropPath, posterPath, title, overview, releaseDate, genres;
  int runtime, voteCount;
  double voteAverage;
  // List<Map<String, dynamic>> genres;
  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        posterPath = json['poster_path'],
        title = json['title'],
        overview = json['overview'],
        releaseDate = json['release_date'],
        runtime = json['runtime'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'],
        // genres = List<Map<String, dynamic>>.from(
        //     json['genres'].map((genre) => Map<String, dynamic>.from(genre)));
        genres = (json['genres'] as List)
            .map((genre) => genre['name'].toString())
            .join(', '); // 장르 이름을 문자열로 결합
}
