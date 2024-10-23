import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/data/db_helper.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_state.dart';
import 'package:movie_discovery_app/App/screens/home_screen/repository/home_screen_repository.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  final HomeScreenRepository homeScreenRepository = HomeScreenRepository();
  final DatabaseHelper dbHelper;
  HomeScreenCubit(this.dbHelper) : super(HomeScreenLoadingState()) {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        init();
      },
    );
  }

  void init() async {
    try {
      List<Movie> pMoviesList = await getMoviesList();
      List<Movie> fMoviesList = await fetchMoviesInDb();

      emit(HomeScreenLoadedState(pMoviesList, fMoviesList));
    } catch (e) {
      emit(HomeScreenErrorState(e.toString()));
    }
  }

  Future<List<Movie>> getMoviesList() async {
    Response? response = await homeScreenRepository.fetchPopulerApi();
    Map<String, dynamic> serchedata = response?.data;
    List<dynamic> responseData = serchedata['Search'];
    List<Movie> dataList =
        responseData.map((item) => Movie.fromJson(item)).toList();
    return dataList;
  }

  // Fetch all movies from local DB
  Future<List<Movie>> fetchMoviesInDb() async {
    final movies = await dbHelper.getMovies();
    return movies;
  }

  // Insert a movie into the local DB
  Future<void> addMovieInDb(Movie movie, BuildContext context) async {
    try {
      bool exists = await dbHelper.isMovieExists(movie.imdbID ?? "");

      if (exists) {
        errorMessage(context, "The movie is already in your favorite list");
        return;
      }

      await dbHelper.insertMovie(movie);
      List<Movie> moviesList = await fetchMoviesInDb();
      emit(HomeScreenLoadedState(state.populerMoviesList, moviesList));

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
      emit(HomeScreenLoadedState(state.populerMoviesList, moviesList));

      successMessage(context, "${movie.title} removed from favorites");
    } catch (e) {
      errorMessage(context, "Failed to remove movie from the database");
    }
  }
}
