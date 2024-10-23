import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/models/movies_details.dart';
import 'package:movie_discovery_app/App/screens/movie_details/repository/movie_details_repository.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieDetailsRepository movieDetailsRepository =
      MovieDetailsRepository();

  MovieDetailsCubit() : super(MovieDetailsLoadingState()) {}

  Future<void> movieDetails({required String imdbID}) async {
    emit(MovieDetailsLoadingState());
    try {
      Response? response =
          await movieDetailsRepository.fetchMovieDetailsApi(imdbID);
      ();
      Map<String, dynamic> serchedata = response?.data;
      String responceKey = serchedata['Response'];

      if (responceKey == 'True') {
        emit(MovieDetailsLoadedState(MoviesDetails.fromJson(serchedata)));
      } else {
        String ErrorKey = serchedata['Error'];

        emit(MovieDetailsErrorState(ErrorKey.toString()));
      }
    } catch (e) {
      emit(MovieDetailsErrorState(e.toString()));
    }
  }
}
