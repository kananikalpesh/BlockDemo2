import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_discovery_app/App/data/constants/color_constants.dart';
import 'package:movie_discovery_app/App/models/movie.dart';
import 'package:movie_discovery_app/App/routes/app_routes.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_cubit.dart';
import 'package:movie_discovery_app/App/screens/home_screen/bloc/home_screen_state.dart';
import 'package:movie_discovery_app/App/screens/home_screen/view/movie_container.dart';
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
      backgroundColor: Colors.white,
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
          "Welcome",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.pushNamed(context, Routes.movieSearch);
              BlocProvider.of<HomeScreenCubit>(context).init();
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
            if (state is HomeScreenLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomeScreenLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.favoritesMoviesList.length > 0) ...[
                    const Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        "Favorite Movies",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ),
                    Container(
                      height: 250,
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          Movie movies = state.favoritesMoviesList[index];
                          return MovieOpenContainer(
                            movie: movies,
                            isHideFav: true,
                            onAddToFavorites: (context, movie) {},
                            onRemoveToFavorites:
                                (BuildContext context, Movie movie) {
                              BlocProvider.of<HomeScreenCubit>(context)
                                  .removeMovieFromDb(movie, context);
                            },
                          );
                        },
                        itemCount: state.favoritesMoviesList.length,
                      ),
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.only(top: 16, left: 16),
                    child: Text(
                      "Popular Movies",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: GridView.builder(
                        itemCount: state.populerMoviesList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing:
                              3, // Horizontal spacing between items
                          mainAxisSpacing: 3, // Vertical spacing between items
                          childAspectRatio:
                              0.75, // Adjust based on your item height/width ratio
                        ),
                        itemBuilder: (context, index) {
                          Movie movies = state.populerMoviesList[index];
                          return MovieOpenContainer(
                            movie: movies,
                            isHideFav: false,
                            onAddToFavorites: (context, movie) {
                              BlocProvider.of<HomeScreenCubit>(context)
                                  .addMovieInDb(movie, context);
                            },
                            onRemoveToFavorites:
                                (BuildContext context, Movie movie) {},
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              );
            }
            // else if (state is HomeScreenErrorState) {
            //   return Center(
            //     child: Text(
            //       state.errorMessage,
            //       style: const TextStyle(color: Colors.red),
            //     ),
            //   );
            // }
            else {
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
