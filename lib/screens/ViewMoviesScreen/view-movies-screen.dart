import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/screens/FeaturedScreen/page/featured-screen.dart';
import 'package:movieapp/screens/HomeScreen/Movies/bloc/Movie_bloc.dart';

class ViewMoviesScreen extends StatefulWidget {
  final bool? selectRecommed;
  final bool? topRated;
  final bool? similar;
  final int? id;
  const ViewMoviesScreen({
    Key? key,
    @required this.selectRecommed,
    @required this.topRated,
    @required this.similar,
    this.id,
  }) : super(key: key);

  @override
  _ViewMoviesScreenState createState() => _ViewMoviesScreenState();
}

class _ViewMoviesScreenState extends State<ViewMoviesScreen> {
  ScrollController _scrollController = new ScrollController();
  bool isLoadingNextPage = false;
  int _page = 1;
  List<MovieResult>? model;
  final MovieBloc _movieBloc = MovieBloc();

  @override
  void initState() {
    super.initState();
    widget.selectRecommed == true
        ? _movieBloc.add(GetNextPageRecommend(_page))
        : widget.topRated == true
            ? _movieBloc.add(GetNextPageTopRated(_page))
            : widget.similar == true
                ? _movieBloc.add(GetNextPageSimilar(_page, widget.id!))
                : _movieBloc.add(GetNextPagePopular(_page));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var urlImage = 'https://image.tmdb.org/t/p/w500';
    var orientation = MediaQuery.of(context).orientation;
    return BlocBuilder<MovieBloc, MovieState>(
      bloc: _movieBloc,
      builder: (context, state) {
        if (state is MovieInitial) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is Movieloaded) {
          model = state.dataRecommend;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('See all'),
            centerTitle: true,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                );
              },
            ),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (!isLoadingNextPage &&
                  _scrollController.position.pixels ==
                      _scrollController.position.maxScrollExtent) {
                setState(() {
                  isLoadingNextPage = true;
                  _page++;
                  widget.selectRecommed == true
                      ? _movieBloc.add(GetNextPageRecommend(_page))
                      : widget.topRated == true
                          ? _movieBloc.add(GetNextPageTopRated(_page))
                          : widget.similar == true
                              ? _movieBloc
                                  .add(GetNextPageSimilar(_page, widget.id!))
                              : _movieBloc.add(GetNextPagePopular(_page));
                });
              }
              return true;
            },
            child: GridView.builder(
                controller: _scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: orientation == Orientation.landscape
                      ? screenWidth * 0.3
                      : screenHeight * 0.5,
                  crossAxisSpacing: screenHeight * 0.02,
                  mainAxisSpacing: screenWidth * 0.02,
                  mainAxisExtent: orientation == Orientation.landscape
                      ? screenWidth * 0.4
                      : screenWidth * 0.7,
                ),
                itemCount: model!.length + 1,
                itemBuilder: (BuildContext ctx, index) {
                  if (index == model!.length) {
                    isLoadingNextPage = false;
                    return Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return FeaturedScreen(
                          id: model![index].id,
                        );
                      }));
                      print('tapped');
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: model![index].posterPath == null
                              ? Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7RyB6wNXTa0DqKQeoBOoOu6_pqCbQmBqVQ&usqp=CAU'))
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      urlImage + model![index].posterPath!,
                                  placeholder: (context, url) {
                                    return Container(
                                      width: screenWidth * 0.5,
                                      child: Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'images/placeholder_box.png')),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Center(
                                        child: Icon(Icons.wifi_off_rounded));
                                  },
                                ),
                        ),
                        Positioned(
                          top: 10,
                          left: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              ),
                              SizedBox(width: 5),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 15,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  model![index]
                                          .voteAverage
                                          .toString()
                                          .substring(0, 3) +
                                      '/10',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}
