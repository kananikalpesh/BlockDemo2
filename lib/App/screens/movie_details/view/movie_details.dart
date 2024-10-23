import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/utils/common.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie? movieData;

  const MovieDetailsScreen({Key? key, required this.movieData})
      : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.movieData != null &&
        widget.movieData?.imdbID != null &&
        widget.movieData!.imdbID!.isNotEmpty) {
      BlocProvider.of<MovieDetailsCubit>(context)
          .movieDetails(imdbID: widget.movieData!.imdbID!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 500),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.movieData?.poster ??
                        "https://via.placeholder.com/300",
                    width: double.infinity,
                    height: 330,
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, progress) {
                      return Center(
                      child: CircularProgressIndicator(
                        value: progress.progress,
                      ),
                    );
                    },
                    errorWidget: (context, url, error) => const Icon(Icons.error,color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
                    builder: (context, state) {
                      if (state is MovieDetailsLoadingState) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (state is MovieDetailsLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.movieDetails.genre != null &&
                                              state.movieDetails.genre!
                                                  .isNotEmpty
                                          ? state.movieDetails.genre!
                                              .split(",")
                                              .join(" • ")
                                          : "N/A",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      state.movieDetails.title ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 22,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      state.movieDetails.rated ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      state.movieDetails.year ?? "N/A",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    child: Text(
                                      formatRuntime(state.movieDetails.runtime),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                              Text(
                                state.movieDetails.plot ?? "N/A",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.scrim,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 15),
                              buildDetailRow(
                                  "Released", state.movieDetails.released),
                              buildDetailRow(
                                  "Director", state.movieDetails.director),
                              buildDetailRow(
                                  "Writer", state.movieDetails.writer),
                              buildDetailRow(
                                  "Actors", state.movieDetails.actors),
                              buildDetailRow(
                                  "Language", state.movieDetails.language),
                              buildDetailRow(
                                  "Country", state.movieDetails.country),
                              buildDetailRow(
                                  "Awards", state.movieDetails.awards),
                              buildDetailRow(
                                  "Box Office", state.movieDetails.boxOffice),
                              buildDetailRow("IMDb Rating",
                                  "${state.movieDetails.imdbRating}/10"),
                              buildDetailRow(
                                  "Metascore", state.movieDetails.metascore),
                              const SizedBox(height: 5),
                              // Ratings Section
                              Text(
                                "Ratings",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.scrim,
                                ),
                              ),
                              ...?state.movieDetails.ratings?.map(
                                (rating) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${rating.source} ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim,
                                        ),
                                      ),
                                      Text(
                                        rating.value ?? "",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is MovieDetailsErrorState) {
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
                      if (state is MovieDetailsErrorState) {
                        return errorMessage(context, state.errorMessage);
                      }
                    },
                  ),
                ],
              ),
            ),
            SafeArea(
                child: Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.scrim.withOpacity(0.5)),
              child: BackButton(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ))
          ],
        ),
      ),
    );
  }

  // Helper function to create a consistent style for each detail row
  Widget buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Theme.of(context).colorScheme.scrim),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.tertiary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailRowWithoutLabel(String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              value ?? "N/A",
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
