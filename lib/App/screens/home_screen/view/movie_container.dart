import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:movie_discovery_app/App/screens/movie_details/view/movie_details.dart';

class MovieOpenContainer extends StatelessWidget {
  final Movie movie;
  final bool isHideFav;
  final Function(BuildContext context, Movie movie) onAddToFavorites;
  final Function(BuildContext context, Movie movie) onRemoveToFavorites;

  const MovieOpenContainer({
    Key? key,
    required this.movie,
    required this.isHideFav,
    required this.onAddToFavorites,
    required this.onRemoveToFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: OpenContainer(
        closedElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        openColor: Colors.transparent,
        closedColor: Colors.white,
        transitionDuration: const Duration(milliseconds: 600),
        openBuilder: (context, _) {
          return BlocProvider<MovieDetailsCubit>(
            create: (context) =>
                MovieDetailsCubit()..movieDetails(imdbID: movie.imdbID ?? ""),
            child: MovieDetailsScreen(
              imdbID: movie.imdbID ?? "",
            ),
          );
        },
        closedBuilder: (context, openContainer) => Hero(
          tag: movie.imdbID ?? "",
          child: GestureDetector(
            onTap: openContainer,
            child: SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                            bottom: Radius.circular(12),
                          ),
                          child: Image.network(
                            movie.poster ?? "https://via.placeholder.com/150",
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                      if (!isHideFav) ...[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                onAddToFavorites(context, movie);
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.favorite_outline,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                      if (isHideFav) ...[
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 30,
                            height: 30,
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            padding: EdgeInsets.zero,
                            child: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                onRemoveToFavorites(context, movie);
                              },
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${movie.year}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
