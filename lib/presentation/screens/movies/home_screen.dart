import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingProvider.notifier).loadNextPage();
  }
  @override
  Widget build(BuildContext context) {

    // final nowPlayingMovies = ref.watch(nowPlayingProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    
    return Column(
      children: [

        const CustomAppbar(),


        MoviesSlideshow(movies: slideShowMovies),

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context, index) {
        //     final movie = nowPlayingMovies[index];
        //     return ListTile(
        //       title: Text(movie.title),
        //       );
        //     },
        //   ),
        // ),
      ]
    );
  }
}