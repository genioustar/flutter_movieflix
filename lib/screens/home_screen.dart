import 'package:flutter/material.dart';
import 'package:toonflex/models/movie_model.dart';
import 'package:toonflex/services/api_service.dart';
import 'package:toonflex/widgets/movie_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> nowPlayingMovies = ApiService.getNowPlaying();

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
      body: FutureBuilder(
        future: nowPlayingMovies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: makeList(snapshot),
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
    );
  }

  ListView makeList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        return Movie(
          index: index,
          movie: snapshot.data![index],
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
