import 'package:flutter/material.dart';
import 'package:toonflex/models/movie_model.dart';
import 'package:toonflex/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final int index;
  final MovieModel movie;
  final int width;
  final bool isPopular;
  const Movie(
      {super.key,
      required this.index,
      required this.movie,
      required this.width,
      required this.isPopular});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              index: index,
              movie: movie,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: width.toDouble(),
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
              "https://image.tmdb.org/t/p/w500${movie.posterPath}",
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(isPopular ? '' : movie.title),
        ],
      ),
    );
  }
}
