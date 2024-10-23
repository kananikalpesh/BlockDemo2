import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/data/constants/color_constants.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_search/cubit/movie_search_cubit.dart';
import 'package:movie_discovery_app/App/screens/movie_search/view/movie_search_container.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
        title: const Text(
          "Search movies",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: searchController,
              onSubmitted: (text) {
                BlocProvider.of<MovieSearchCubit>(context)
                    .searchData(query: text);
              },
              decoration: InputDecoration(
                hintText: "Search movies...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  borderSide:
                      BorderSide(color: Colors.blue.shade300, width: 1.5),
                ),
              ),
              style: const TextStyle(color: Colors.black87, fontSize: 16),
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
                        return MovieOpenContainerSearch(
                          movie: movies,
                          isHideFav: false,
                          onAddToFavorites: (context, movie) {
                            BlocProvider.of<MovieSearchCubit>(context)
                                .addMovieInDb(movie);
                          },
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.movie_outlined,
                            color: AppColors.secondaryColor,
                            size: 50,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Start Searching for Movies!",
                            style: TextStyle(
                              color: AppColors.secondaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Use the search bar above to find your favorite movies.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
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
