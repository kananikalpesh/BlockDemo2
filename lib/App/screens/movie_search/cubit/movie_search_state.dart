part of 'movie_search_cubit.dart';

sealed class MovieSearchState {
  List<Movie> populerMoviesList;
  List<Movie> favoritesMoviesList;
  MovieSearchState(
    this.populerMoviesList,
      this.favoritesMoviesList
  );
}

class MovieSearchEmptyState extends MovieSearchState {
  MovieSearchEmptyState() : super([],[]);
}

class MovieSearchLoadingState extends MovieSearchState {
  MovieSearchLoadingState() : super([],[]);
}

class MovieSearchLoadedState extends MovieSearchState {
  MovieSearchLoadedState(
    super.populerMoviesList,
      super.favoritesMoviesList
  );
}

class MovieSearchErrorState extends MovieSearchState {
  final String errorMessage;
  MovieSearchErrorState(this.errorMessage) : super([],[]);
}
