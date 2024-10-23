import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:movie_discovery_app/App/screens/movie_details/view/movie_details.dart';

class MovieOpenContainerSearch extends StatelessWidget {
  final Movie movie;
  final bool isHideFav;
  final Function(BuildContext context, Movie movie) onAddToFavorites;

  const MovieOpenContainerSearch({
    Key? key,
    required this.movie,
    required this.isHideFav,
    required this.onAddToFavorites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      // openColor: Colors.transparent,
      // closedColor: Colors.transparent,
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
          child: Container(
            height: 120,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Year: ${movie.year}",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                        if (!isHideFav) ...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                onAddToFavorites(context, movie);
                              },
                              icon: const Icon(Icons.favorite_outline),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
