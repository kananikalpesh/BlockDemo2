import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_discovery_app/App/data/db_helper.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_search/repository/movie_search_repository.dart';

part 'movie_search_state.dart';

class MovieSearchCubit extends Cubit<MovieSearchState> {
  final DatabaseHelper dbHelper;
  MovieSearchCubit(this.dbHelper) : super(MovieSearchEmptyState());

  final MovieSearchRepository movieSearchRepository = MovieSearchRepository();

  Future<void> searchData({required String query}) async {
    emit(MovieSearchLoadingState());
    try {
      Response? response =
          await movieSearchRepository.fetchSearchApi(query, null);
      ();
      Map<String, dynamic> serchedata = response?.data;
      List<dynamic> responseData = serchedata['Search'];
      List<Movie> dataList =
          responseData.map((item) => Movie.fromJson(item)).toList();
      emit(MovieSearchLoadedState(dataList));
    } catch (e) {
      emit(MovieSearchErrorState(e.toString()));
    }
  }

  Future<void> addMovieInDb(Movie movie) async {
    try {
      await dbHelper.insertMovie(movie);
    } catch (e) {
      emit(MovieSearchErrorState('Failed to add movie to the database'));
    }
  }
}
