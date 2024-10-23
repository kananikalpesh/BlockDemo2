import 'package:flutter/material.dart';
import 'package:movie_discovery_app/App/routes/app_routes.dart';
import 'package:movie_discovery_app/App/routes/route_navigator.dart';
import 'package:movie_discovery_app/App/utils/theme/bloc/theme_cubit.dart';
import 'package:movie_discovery_app/App/utils/theme/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: Routes.initial,
    //   routes: RouteNavigator.routes,
    // );

    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            theme: themeState.themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.initial,
            routes: RouteNavigator.routes,
          );
        },
      ),
    );
  }
}
