import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/routes/app_routes.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_cubit.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_state.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, Routes.movieSearch);
              BlocProvider.of<HomeScreenCubit>(context).init();
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            ///Cubit ma direct function call thache
            /// cubit kkoi event send kar va mate direct function call kar va nu
            /// BlocProvider.of<HomeScreenCubit>(context).getUsersList();

            if (state is HomeScreenLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeScreenLoadedState) {
              return Column(
                children: [
                  const Text(
                    "Populer Movies",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Movie movies = state.populerMoviesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.movieDetails,
                                arguments: movies.imdbID);
                          },
                          child: Container(
                            height: 300,
                            color: Colors.greenAccent,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Title :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.title ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "imdbID :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.imdbID ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Year :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.year ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<HomeScreenCubit>(context)
                                          .addMovieInDb(movies);
                                    },
                                    icon: Icon(Icons.favorite_outline),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.populerMoviesList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Favorites Movies",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Movie movies = state.favoritesMoviesList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.movieDetails,
                                arguments: movies.imdbID);
                          },
                          child: Container(
                            height: 300,
                            color: Colors.greenAccent,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Title :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.title ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "imdbID :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.imdbID ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Year :",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    movies.year ?? "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<HomeScreenCubit>(context)
                                          .addMovieInDb(movies);
                                    },
                                    icon: Icon(Icons.favorite_outline),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: state.favoritesMoviesList.length,
                    ),
                  ),
                ],
              );
            } else if (state is HomeScreenErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(
                child: Text(
                  "en error occur",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
          listener: (context, state) {
            if (state is HomeScreenErrorState) {
              return errorMessage(context, state.errorMessage);
            }
          },
        ),
      ),
    );
  }
}
