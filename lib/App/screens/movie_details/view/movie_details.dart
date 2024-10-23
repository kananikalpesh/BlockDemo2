import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_discovery_app/App/data/constants/color_constants.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/utils/common.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String imdbID;

  const MovieDetailsScreen({Key? key, required this.imdbID}) : super(key: key);

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.imdbID != null && widget.imdbID.isNotEmpty) {
      BlocProvider.of<MovieDetailsCubit>(context)
          .movieDetails(imdbID: widget.imdbID);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

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
          "Movie Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsLoadedState) {
            return AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.imdbID, // Match the Hero tag
                    child: Image.network(
                      state.movieDetails.poster ??
                          "https://via.placeholder.com/300",
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    state.movieDetails.genre != null &&
                                            state.movieDetails.genre!.isNotEmpty
                                        ? state.movieDetails.genre!
                                            .split(",")
                                            .join(" • ")
                                        : "N/A",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black54),
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
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: Colors.black,
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
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    state.movieDetails.rated ?? "N/A",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    state.movieDetails.year ?? "N/A",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    formatRuntime(state.movieDetails.runtime),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
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
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(height: 15),
                            buildDetailRow(
                                "Released", state.movieDetails.released),
                            buildDetailRow(
                                "Director", state.movieDetails.director),
                            buildDetailRow("Writer", state.movieDetails.writer),
                            buildDetailRow("Actors", state.movieDetails.actors),
                            buildDetailRow(
                                "Language", state.movieDetails.language),
                            buildDetailRow(
                                "Country", state.movieDetails.country),
                            buildDetailRow("Awards", state.movieDetails.awards),
                            buildDetailRow(
                                "Box Office", state.movieDetails.boxOffice),
                            buildDetailRow("IMDb Rating",
                                "${state.movieDetails.imdbRating}/10"),
                            buildDetailRow(
                                "Metascore", state.movieDetails.metascore),
                            const SizedBox(height: 5),
                            // Ratings Section
                            const Text(
                              "Ratings",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            ...?state.movieDetails.ratings?.map(
                              (rating) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      "${rating.source} ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      rating.value ?? "",
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Expanded(
            child: Text(
              value ?? "N/A",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
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
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
