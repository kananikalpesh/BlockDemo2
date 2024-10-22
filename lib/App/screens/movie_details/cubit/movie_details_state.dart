part of 'movie_details_cubit.dart';

sealed class MovieDetailsState {}

class MovieDetailsEmptyState extends MovieDetailsState {
  MovieDetailsEmptyState();
}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsLoadedState extends MovieDetailsState {
  MoviesDetails movieDetails;

  MovieDetailsLoadedState(
    this.movieDetails,
  );
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;
  MovieDetailsErrorState(this.errorMessage);
}
