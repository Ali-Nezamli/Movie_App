import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/bloc/series_bloc.dart';
import 'package:movieapp/screens/HomeScreen/page/bottom_nav_bar_page.dart';

import 'screens/HomeScreen/Movies/bloc/Movie_bloc.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieBloc(),
        ),
        BlocProvider(
          create: (context) => SeriesBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: BottomNavBarScreen(),
      ),
    );
  }
}
