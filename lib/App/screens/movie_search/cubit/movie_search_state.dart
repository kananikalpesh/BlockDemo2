part of 'movie_search_cubit.dart';

sealed class MovieSearchState {
  List<Movie> populerMoviesList;

  MovieSearchState(
    this.populerMoviesList,
  );
}

class MovieSearchEmptyState extends MovieSearchState {
  MovieSearchEmptyState() : super([]);
}

class MovieSearchLoadingState extends MovieSearchState {
  MovieSearchLoadingState() : super([]);
}

class MovieSearchLoadedState extends MovieSearchState {
  MovieSearchLoadedState(
    super.populerMoviesList,
  );
}

class MovieSearchErrorState extends MovieSearchState {
  final String errorMessage;
  MovieSearchErrorState(this.errorMessage) : super([]);
}
