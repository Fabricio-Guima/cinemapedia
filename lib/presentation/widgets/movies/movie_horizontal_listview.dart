import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:go_router/go_router.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key, 
    required this.movies, 
    this.title, 
    this.subtitle, 
    this.loadNextPage
    });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  
  final scrollController = ScrollController();

  @override
  void initState(){
    super.initState();

    scrollController.addListener((){
      if(widget.loadNextPage == null) return;

      if( (scrollController.position.pixels + 200) >= scrollController.position.maxScrollExtent ) {
       
        widget.loadNextPage!();
      }

    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if(widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length + 1,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              cacheExtent: 300,
              itemBuilder: (context, index) {
                if (index == widget.movies.length) {
                    // Último item: indicador de carregamento
                    return const SizedBox(
                      width: 150,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return FadeInRight(child: _Slide(movie: widget.movies[index]));
              }
            ),
          ),          
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({   
    required this.movie
    });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          SizedBox(
            width: 150,
            height: 210,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if(loadingProgress != null) {
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  }
                  return GestureDetector(
                    onTap: () => context.push('/movie/${movie.id}'),
                    child: FadeIn(child: child),
                  );
                 
                } ,
              )
              ),
          ),

          const SizedBox(height: 5),

          // Title
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyles.titleSmall,
            ),
          ),
          // Rating
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(height: 3),
                Text('${movie.voteAverage}', style: textStyles.bodyMedium?.copyWith( color: Colors.yellow.shade800)),
               
                // Text('${ movie.popularity }', style: textStyles.bodySmall,)
                
                const Spacer(),
                Text( HumanFormats.number(movie.popularity),
                    style: textStyles.bodySmall )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({     
    this.title, 
    this.subtitle
    });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if(title != null)
            Text(title!, style: titleStyle,),
          const Spacer(),
          if(subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: (){}, 
              child: Text(subtitle!))
        ],
      ),
    
    );
  }
}