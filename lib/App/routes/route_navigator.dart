import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/data/db_helper.dart';
import 'package:movie_discovery_app/App/routes/app_routes.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_cubit.dart';
import 'package:movie_discovery_app/App/screens/home_screen/view/home_screen.dart';
import 'package:movie_discovery_app/App/screens/movie_details/view/movie_details.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';

import 'package:movie_discovery_app/App/screens/movie_search/view/movie_search.dart';
import 'package:movie_discovery_app/App/screens/movie_search/cubit/movie_search_cubit.dart';

abstract class RouteNavigator {
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.homeScreen: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeScreenCubit(DatabaseHelper()),
        child: const HomeScreen(),
      );
    },
    Routes.movieSearch: (BuildContext context) {
      return BlocProvider(
        create: (context) => MovieSearchCubit(DatabaseHelper()),
        child: const MovieSearch(),
      );
    },
    Routes.movieDetails: (BuildContext context) {
      return BlocProvider(
        create: (context) => MovieDetailsCubit(),
        child: MovieDetailsScreen(
          imdbID: '',
        ),
      );
    },
  };
}
