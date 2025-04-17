import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';

final initialLoginLoadingProvider = Provider<bool>((ref) {

  final nowPlayingMovies = ref.watch(nowPlayingProvider).isEmpty;
  final popularMovies = ref.watch(popularProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingProvider).isEmpty;

  if (nowPlayingMovies || popularMovies || topRatedMovies || upcomingMovies) return true;

  return false;
} );