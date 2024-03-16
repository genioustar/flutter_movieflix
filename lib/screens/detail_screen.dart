import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toonflex/models/movie_detail_model.dart';
import 'package:toonflex/models/movie_model.dart';
import 'package:toonflex/services/api_service.dart';
import 'package:toonflex/widgets/buy_button_widget.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final MovieModel movie;
  const DetailScreen({super.key, required this.index, required this.movie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late final Future<MovieDetailModel> movieDetail;
  late final SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedMovies = prefs.getStringList('likedMovies');
    if (likedMovies != null) {
      if (likedMovies.contains(widget.movie.id.toString())) {
        setState(() {
          isLiked = true;
        });
      } else {
        print('This movie is not liked');
      }
    } else {
      prefs.setStringList('likedMovies', []);
    }
  }

  onHeartTap() {
    final likedMovies = prefs.getStringList('likedMovies');
    if (likedMovies != null) {
      if (isLiked) {
        likedMovies.remove(widget.movie.id.toString());
      } else {
        likedMovies.add(widget.movie.id.toString());
      }
      prefs.setStringList('likedMovies', likedMovies);
    }
    setState(() {
      isLiked = !isLiked;
    });
  }

// build 하기전에 단 한번만 실행(initState())
  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail(widget.movie.id.toString());
    initPrefs();
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
        actions: [
          IconButton(
            onPressed: () {
              onHeartTap();
            },
            icon:
                Icon(isLiked ? Icons.favorite : Icons.favorite_border_outlined),
            color: Colors.black,
          ),
        ],
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
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.overview),
                      const SizedBox(height: 20),
                      Text(snapshot.data!.genres),
                      const SizedBox(height: 20),
                      BuyButtonWidgets(url: snapshot.data!.homepage),
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
