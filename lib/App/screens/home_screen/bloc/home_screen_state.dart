import 'package:movie_discovery_app/App/models/movie.dart';

sealed class HomeScreenState {
  List<Movie> populerMoviesList;
  List<Movie> favoritesMoviesList;

  HomeScreenState(this.populerMoviesList, this.favoritesMoviesList);
}

class HomeScreenLoadingState extends HomeScreenState {
  HomeScreenLoadingState() : super([], []);
}

class HomeScreenLoadedState extends HomeScreenState {
  HomeScreenLoadedState(super.populerMoviesList, super.favoritesMoviesList);
}

class HomeScreenErrorState extends HomeScreenState {
  final String errorMessage;
  HomeScreenErrorState(this.errorMessage) : super([], []);
}
