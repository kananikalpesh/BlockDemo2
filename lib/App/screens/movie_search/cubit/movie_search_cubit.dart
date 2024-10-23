import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_discovery_app/App/data/db_helper.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_search/repository/movie_search_repository.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final DatabaseHelper dbHelper;
  MovieSearchCubit(this.dbHelper) : super(MovieSearchEmptyState());

  final MovieSearchRepository movieSearchRepository = MovieSearchRepository();

  Future<void> searchData({required String query}) async {
    emit(MovieSearchLoadingState());
    try {
      Response? response = await movieSearchRepository.fetchSearchApi(query);
      ();
      Map<String, dynamic> serchedata = response?.data;

      String responceKey = serchedata['Response'];

      if (responceKey == 'True') {
        List<dynamic> responseData = serchedata['Search'];
        List<Movie> dataList =
            responseData.map((item) => Movie.fromJson(item)).toList();

        List<Movie> favoritesMoviesList = await fetchMoviesInDb();
        emit(MovieSearchLoadedState(dataList,favoritesMoviesList));
      } else {
        String ErrorKey = serchedata['Error'];

        emit(MovieSearchErrorState(ErrorKey.toString()));
      }
    } catch (e) {
      emit(MovieSearchErrorState(e.toString()));
    }
  }

  Future<List<Movie>> fetchMoviesInDb() async {
    final movies = await dbHelper.getMovies();
    return movies;
  }

  Future<void> addMovieInDb(Movie movie, BuildContext context) async {
    try {
      bool exists = await dbHelper.isMovieExists(movie.imdbID ?? "");

      if (exists) {
        errorMessage(context, "The movie is already in your favorite list");
        return;
      }

      await dbHelper.insertMovie(movie);

      List<Movie> moviesList = await fetchMoviesInDb();
      emit(MovieSearchLoadedState(state.populerMoviesList, moviesList));

      successMessage(context, "${movie.title} added to favorites");
    } catch (e) {
      errorMessage(context, "Movie already exists in the database");
    }
  }

  Future<void> removeMovieFromDb(Movie movie, BuildContext context) async {
    try {
      // Remove the movie using dbHelper
      await dbHelper.deleteMovie(movie.imdbID ?? "");

      // Fetch updated movie list after deletion
      List<Movie> moviesList = await fetchMoviesInDb();
      // Emit the updated state with the modified movie list
      emit(MovieSearchLoadedState(state.populerMoviesList, moviesList));

      successMessage(context, "${movie.title} removed from favorites");
    } catch (e) {
      errorMessage(context, "Failed to remove movie from the database");
    }
  }
}
