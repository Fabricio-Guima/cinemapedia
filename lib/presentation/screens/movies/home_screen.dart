import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
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
    ref.read(popularProvider.notifier).loadNextPage();
    ref.read(topRatedProvider.notifier).loadNextPage();
    ref.read(upcomingProvider.notifier).loadNextPage();
  }
  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoginLoadingProvider);
    if(initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingProvider);
    final popularMovies = ref.watch(popularProvider);
    final topRatedMovies = ref.watch(topRatedProvider);
    final upcomingMovies = ref.watch(upcomingProvider);  
    
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,         
            title: CustomAppbar(),          
        ),
        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index)  {
            return       Column(
        children: [
      
          // const CustomAppbar(),
      
      
          MoviesSlideshow(movies: slideShowMovies),
      
          MovieHorizontalListview(
            movies: nowPlayingMovies,
            title: 'Now in Theaters',
            subtitle: 'Monday 5',
            loadNextPage: () { 
              ref.read(nowPlayingProvider.notifier).loadNextPage();
              },
          ),
      
          MovieHorizontalListview(
            movies: upcomingMovies,
            title: 'Coming Soon',
            subtitle: 'Saturday 20',
            loadNextPage: () {
              ref.read(upcomingProvider.notifier).loadNextPage();
            },
          ),
      
          MovieHorizontalListview(
            movies: popularMovies,
            title: 'Popular',
            // subtitle: 'Sunday 20',
            loadNextPage: () {
              ref.read(popularProvider.notifier).loadNextPage();
            },
          ),
      
          MovieHorizontalListview(
            movies: topRatedMovies,
            title: 'Top Rated Movies',
            // subtitle: 'Sunday 20',
            loadNextPage: () {
              ref.read(topRatedProvider.notifier).loadNextPage();
            },
          ),
          const SizedBox(height: 10)
        ]
      );
          },
          childCount: 1
        )),
      ]

    );
  }
}