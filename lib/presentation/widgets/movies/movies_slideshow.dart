import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  const MoviesSlideshow({
    super.key, 
    required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity,      
      child: Swiper(
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary
          ) 
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {          
          return _Slide(movie: movies[index]);
        },
        ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(movie.backdropPath, 
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if(loadingProgress != null) {
              return const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black12
                ),
              );
            } else {
              return FadeIn(child: child);
            }
          },
          ),

        )
        ),

      );
  }
}