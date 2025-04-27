// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  Timer ? _debounceTimer;
  SearchMovieDelegate({
    required this.searchMovies,
  });

  void clearStreams(){
    debouncedMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if(query.isEmpty) {
        debouncedMovies.add([]);
        return;
      }

      final movies = await searchMovies(query);
      debouncedMovies.add(movies);
    });
   
  }

  @override
  String? get searchFieldLabel => 'Buscar filme';

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [      
        FadeIn(
          animate: query.isNotEmpty,
          duration: const Duration(milliseconds: 200),
          child: IconButton(
            onPressed: () => query = '', 
            icon: const Icon(Icons.clear)
          ),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
        }, 
      icon:  const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return StreamBuilder(
      stream: debouncedMovies.stream,     
      builder: (context, snapshot) {
        
        final movies = snapshot.data ?? [];
        return ListView.builder(   
          itemCount: movies.length,       
          itemBuilder: (context, index) => _MovieItem(movie: movies[index],         
          onMovieSelected: (context, movie){
            clearStreams();
            close(context, movies[index]);}
        )
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            SizedBox(
              width: size.width * 0.2,
              height: size.width * 0.2 * 1.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath.isNotEmpty
                      ? movie.posterPath
                      : 'https://fireteller.com.au/wp-content/uploads/2020/09/Poster_Not_Available2.jpg',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Image.network(
                    'https://fireteller.com.au/wp-content/uploads/2020/09/Poster_Not_Available2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.7,
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.overview.isNotEmpty
                        ? (movie.overview.length > 100
                            ? '${movie.overview.substring(0, 100)}...'
                            : movie.overview)
                        : '',
                    style: textStyles.bodySmall,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.number(movie.voteAverage, 1),
                        style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                        ),
                    ],
                  ),
                ],
              ),
      
            ),
          ],
        ),
      ),
    );
  }
}

