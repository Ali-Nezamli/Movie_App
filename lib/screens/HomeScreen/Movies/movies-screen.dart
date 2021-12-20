import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/screens/HomeScreen/Movies/bloc/Movie_bloc.dart';
import 'package:movieapp/screens/HomeScreen/widgets/list-view-movies.dart';
import 'package:movieapp/screens/HomeScreen/widgets/swiper.dart';
import 'package:movieapp/screens/ViewMoviesScreen/view-movies-screen.dart';
import 'package:movieapp/screens/Widgets/no-wifi.dart';

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<MovieResult>? popularModel;
  List<MovieResult>? recommendModel;
  List<MovieResult>? topRatedModel;
  List<MovieResult>? nowPlayingModel;
  var urlImage = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieInitial) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          recommendModel = state.dataRecommend;

          popularModel = state.dataPopular;
          topRatedModel = state.dataTopRated;
          nowPlayingModel = state.dataNowPlaying;
        } else if (state is MovieError) {
          return Center(
            child: NoWifi(
              onPressed: () {
                BlocProvider.of<MovieBloc>(context).add(GetMovies(1));
              },
            ),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: orientation == Orientation.landscape
                    ? screenHeight * 0.6
                    : screenHeight * 0.45,
                child: SwiperImages(
                  nowPlayingModel: nowPlayingModel!,
                  urlImage: urlImage,
                ),
              ),
              ListViewMovies(
                  onTapSeeall: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewMoviesScreen(
                        selectRecommed: true,
                        topRated: false,
                        similar: false,
                      );
                    }));
                  },
                  title: 'Upcoming',
                  movieModel: recommendModel!,
                  urlImage: urlImage),
              ListViewMovies(
                  onTapSeeall: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewMoviesScreen(
                        selectRecommed: false,
                        topRated: false,
                        similar: false,
                      );
                    }));
                  },
                  title: 'Popular',
                  movieModel: popularModel!,
                  urlImage: urlImage),
              ListViewMovies(
                  onTapSeeall: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ViewMoviesScreen(
                        selectRecommed: false,
                        topRated: true,
                        similar: false,
                      );
                    }));
                  },
                  title: 'Top Rated',
                  movieModel: topRatedModel!,
                  urlImage: urlImage),
            ],
          ),
        );
      },
    );
  }
}
