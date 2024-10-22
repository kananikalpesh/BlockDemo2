import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/routes/app_routes.dart';
import 'package:movie_discovery_app/App/screens/movie_search/cubit/movie_search_cubit.dart';

class MovieSearch extends StatefulWidget {
  const MovieSearch({super.key});

  @override
  State<MovieSearch> createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: searchController,
              onSubmitted: (text) {
                BlocProvider.of<MovieSearchCubit>(context)
                    .searchData(query: text);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<MovieSearchCubit, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is MovieSearchLoadedState) {
                    return ListView.builder(
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
                                      BlocProvider.of<MovieSearchCubit>(context)
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
                    );
                  } else if (state is MovieSearchErrorState) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is MovieSearchEmptyState) {
                    return const Center(
                      child: Text(
                        "Please search movie",
                        style: TextStyle(color: Colors.red),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
