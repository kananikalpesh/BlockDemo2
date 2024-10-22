import 'package:flutter/widgets.dart';
import 'package:movie_discovery_app/App/screens/movie_details/cubit/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/widgets/snack_bar.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetailsScreen> {
  String? imdbID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // imdbID = ModalRoute.of(context)?.settings.arguments as dynamic;
    // BlocProvider.of<MovieDetailsCubit>(context)
    //     .movieDetails(imdbID: imdbID ?? "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve the route arguments safely after initState
    imdbID = ModalRoute.of(context)?.settings.arguments as String?;

    // Fetch movie details using the Cubit, after the widget context is ready
    if (imdbID != null && imdbID!.isNotEmpty) {
      BlocProvider.of<MovieDetailsCubit>(context).movieDetails(imdbID: imdbID!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          ///Cubit ma direct function call thache
          /// cubit kkoi event send kar va mate direct function call kar va nu
          /// BlocProvider.of<HomeScreenCubit>(context).getUsersList();

          if (state is MovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MovieDetailsLoadedState) {
            return Column(
              children: [
                const Text(
                  "Populer Movies",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Title :",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.movieDetails.title ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black45),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "imdbID :",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.movieDetails.imdbID ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black45),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Year :",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  state.movieDetails.year ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: Colors.black45),
                ),
              ],
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
    ));
  }
}
