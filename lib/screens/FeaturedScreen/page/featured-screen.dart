import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/models/Screen-shots-model.dart';
import 'package:movieapp/Data/models/credits-model.dart';
import 'package:movieapp/Data/models/details-modal.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/Data/models/video-model.dart';
import 'package:movieapp/screens/FeaturedScreen/bloc/moviedetails_bloc.dart';
import 'package:movieapp/screens/FeaturedScreen/widgets/cast-list-view.dart';
import 'package:movieapp/screens/FeaturedScreen/widgets/custom-card.dart';
import 'package:movieapp/screens/FeaturedScreen/widgets/movie-genres.dart';
import 'package:movieapp/screens/FeaturedScreen/widgets/screenshots-listlview.dart';
import 'package:movieapp/screens/HomeScreen/widgets/list-view-movies.dart';
import 'package:movieapp/screens/ViewMoviesScreen/view-movies-screen.dart';
import 'package:movieapp/screens/WatchVideoScreen/watch-video.dart';
import 'package:movieapp/screens/Widgets/bottom-flush-bar.dart';
import 'package:movieapp/screens/Widgets/no-wifi.dart';

class FeaturedScreen extends StatefulWidget {
  final int? id;
  const FeaturedScreen({
    this.id,
  });

  @override
  _FeaturedScreenState createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  ScreenShots? screenShots;
  CreditsModel? creditsModel;
  DetailsModel? detailsModel;
  VideosModel? videosModel;
  List<MovieResult>? similarModel;
  var urlImage = 'https://image.tmdb.org/t/p/original';
  final MoviedetailsBloc _moviedetailsBloc = MoviedetailsBloc();

  @override
  void initState() {
    super.initState();
    _moviedetailsBloc.add(GetMovieDetails(widget.id!));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: BlocBuilder<MoviedetailsBloc, MoviedetailsState>(
        bloc: _moviedetailsBloc,
        builder: (context, state) {
          if (state is MoviedetailsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviedetailsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MoviedetailsLoaded) {
            detailsModel = state.dataDetails;
            creditsModel = state.dataCredits;
            screenShots = state.dataScreenShots;
            videosModel = state.datavideoModel;
            similarModel = state.dataSimiler;
          } else if (state is MoviedetailsError) {
            return Center(
              child: NoWifi(
                onPressed: () {
                  _moviedetailsBloc.add(GetMovieDetails(widget.id!));
                },
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: orientation == Orientation.landscape
                              ? screenHeight / 0.7
                              : screenHeight / 1.9,
                        ),
                        Container(
                          width: double.infinity,
                          height: orientation == Orientation.landscape
                              ? screenHeight / 1
                              : screenHeight / 2.5,
                          child: ClipPath(
                            clipper: DiagonalClipper(),
                            child: detailsModel!.backdropPath == null
                                ? Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7RyB6wNXTa0DqKQeoBOoOu6_pqCbQmBqVQ&usqp=CAU'))
                                : CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        urlImage + detailsModel!.backdropPath!,
                                    placeholder: (context, url) {
                                      return Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'images/placeholder_cover.jpg'));
                                    },
                                    errorWidget: (context, url, error) {
                                      return Icon(
                                        Icons.wifi_off_rounded,
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: screenWidth * 0.05,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: orientation == Orientation.landscape
                                    ? screenHeight / 1.2
                                    : screenHeight / 4,
                                width: screenWidth * 0.3,
                                child: detailsModel!.posterPath == null
                                    ? Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7RyB6wNXTa0DqKQeoBOoOu6_pqCbQmBqVQ&usqp=CAU'))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: urlImage +
                                              detailsModel!.posterPath!,
                                          placeholder: (context, url) {
                                            return Image(
                                                fit: BoxFit.cover,
                                                image: AssetImage(
                                                    'images/placeholder_box.png'));
                                          },
                                          errorWidget: (context, url, error) {
                                            return Icon(
                                              Icons.wifi_off_rounded,
                                            );
                                          },
                                        ),
                                      ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Container(
                                width: screenWidth * 0.55,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                        ),
                                        child: Text(
                                          detailsModel!.originalTitle!,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            print('tapped');
                                            videosModel!.results!.isEmpty
                                                ? bottomFlushBar(context,
                                                    "No Trailer Available")
                                                : Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                    return WatchVideo(
                                                      id: videosModel!
                                                          .results![0].key,
                                                      image: detailsModel!
                                                          .posterPath!,
                                                    );
                                                  }));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenHeight * 0.05),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        blurRadius: 5)
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: Colors.white,
                                                  )),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .play_circle_fill_rounded,
                                                        size: 22,
                                                        color: Colors.white),
                                                    Text(
                                                      'Watch Trailer',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 35)
                                ],
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                            )),
                      ],
                    ),
                    SizedBox(height: 30),
                    MovieGenres(detailsModel: detailsModel),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              width: 2,
                              color: Colors.blueGrey,
                            )),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                          child: Column(
                            children: [
                              Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popularity',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.add_reaction,
                                    color: Colors.blueGrey,
                                    size: 15,
                                  ),
                                ],
                              ),
                              Text(
                                detailsModel!.popularity!.toStringAsFixed(2),
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[300],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomCard(
                            title: 'Year',
                            label: detailsModel!.releaseDate == null
                                ? 'No ReleaseDate'
                                : detailsModel!.releaseDate,
                          ),
                          CustomCard(
                            title: 'Rate',
                            label: detailsModel!.voteAverage.toString() + '/10',
                          ),
                          CustomCard(
                            title: 'Duration',
                            label: detailsModel!.runtime == null
                                ? 'No ReleaseDate'
                                : detailsModel!.runtime.toString() + ' min',
                          )
                        ],
                      ),
                    ),
                    creditsModel == null
                        ? SizedBox()
                        : CastListView(
                            creditsModel: creditsModel,
                            urlImage: urlImage,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(detailsModel!.overview!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(height: 30),
                    screenShots == null
                        ? SizedBox()
                        : ScreenShotsListView(
                            screenShots: screenShots, urlImage: urlImage),
                    SizedBox(height: 30),
                    similarModel == null
                        ? SizedBox()
                        : ListViewMovies(
                            movieModel: similarModel!,
                            urlImage: urlImage,
                            title: "Similar Movies",
                            onTapSeeall: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ViewMoviesScreen(
                                  selectRecommed: false,
                                  topRated: false,
                                  similar: true,
                                  id: widget.id!,
                                );
                              }));
                            },
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
