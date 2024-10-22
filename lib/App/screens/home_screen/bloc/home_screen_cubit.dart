import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/data/db_helper.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_state.dart';
import 'package:movie_discovery_app/App/screens/home_screen/repository/home_screen_repository.dart';

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
  Future<void> addMovieInDb(Movie movie) async {
    try {
      await dbHelper.insertMovie(movie);
      List<Movie> moviesList = await fetchMoviesInDb();
      emit(HomeScreenLoadedState(state.populerMoviesList, moviesList));
      // Re-fetch movies after insertion
    } catch (e) {
      emit(HomeScreenErrorState('Failed to add movie to the database'));
    }
  }

  // Clear all movies from the local DB
  Future<void> clearMoviesInDb() async {
    try {
      await dbHelper.deleteAllMovies();
      fetchMoviesInDb(); // Re-fetch movies after deletion
    } catch (e) {
      emit(HomeScreenErrorState('Failed to clear movies from the database'));
    }
  }
}
