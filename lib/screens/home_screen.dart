import 'package:flutter/material.dart';
import 'package:toonflex/models/movie_model.dart';
import 'package:toonflex/services/api_service.dart';
import 'package:toonflex/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> nowPlayingMovies = ApiService.getNowPlaying();
  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> comingSoonMovies = ApiService.getComingSoon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Movieflix',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Popular Movies',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 16),
              FutureBuilder(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makePopMovies(snapshot);
                  } else {
                    return const Placeholder();
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Now in Cinemas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              FutureBuilder(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: makeNowMovieList(snapshot),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Coming Soon',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              FutureBuilder(
                future: comingSoonMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return makePopMovies(snapshot);
                  } else {
                    return const Placeholder();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView makePopMovies(
      AsyncSnapshot<List<MovieModel>> snapshot) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          20,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Movie(
                index: index,
                movie: snapshot.data![index],
                width: 200,
                isPopular: true,
              ),
            );
          },
        ),
      ),
    );
  }

  ListView makeNowMovieList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return Movie(
          index: index,
          movie: snapshot.data![index],
          width: 100,
          isPopular: false,
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          indent: 20,
        );
      },
    );
  }
}
