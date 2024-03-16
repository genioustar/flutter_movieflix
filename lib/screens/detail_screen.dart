import 'package:flutter/material.dart';
import 'package:toonflex/models/movie_detail_model.dart';
import 'package:toonflex/models/movie_model.dart';
import 'package:toonflex/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final MovieModel movie;
  const DetailScreen({super.key, required this.index, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail(widget.movie.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: widget.movie.id,
                child: Container(
                  width: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500${widget.movie.posterPath}",
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.overview),
                      const SizedBox(height: 20),
                      Text(snapshot.data!.genres),
                    ],
                  ),
                );
              } else {
                return const Text('Loading...');
              }
            },
          ),
        ],
      ),
    );
  }
}
