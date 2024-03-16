class MovieModel {
  bool adult, video;
  String backdropPath,
      originalLanguage,
      originalTitle,
      overview,
      releaseDate,
      title,
      posterPath;
  int id, voteCount;
  double popularity;
  dynamic voteAverage; // double or int
  List<int> genreIds;

// named constructor
  MovieModel.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = json['genre_ids'].cast<int>(),
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}
