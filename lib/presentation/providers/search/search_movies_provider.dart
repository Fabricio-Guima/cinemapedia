import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');


final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {

 final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovies,
    ref: ref,
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);


class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {

  final Ref ref;

  SearchMoviesCallback searchMovies;
  
  SearchedMoviesNotifier({
    required this.ref, 
    required this.searchMovies
  }):super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }

}