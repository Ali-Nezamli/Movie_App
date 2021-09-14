import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/screens/FeaturedScreen/page/featured-screen.dart';
import 'package:movieapp/screens/SearchScreen/Bloc/search_bloc.dart';
import 'package:movieapp/screens/Widgets/bottom-flush-bar.dart';
import 'package:movieapp/screens/Widgets/no-wifi.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<MovieResult>? movieSearchModel;
  bool? showButton;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String movieName = '';
  var urlImage = 'https://image.tmdb.org/t/p/w500';
  final SearchBloc _searchBloc = SearchBloc();
  bool isLoadingNextPage = false;
  ScrollController _scrollController = new ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    return BlocProvider(
      create: (context) => _searchBloc,
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is SearchLoaded) {
            movieSearchModel = state.dataSearch;
          }
          if (state is NextSearchLoaded) {
            movieSearchModel = state.dataSearch;
          }
          if (state is SearchError) {
            // ignore: deprecated_member_use
            bottomFlushBar(context, 'Network Error Try Again');
          }
        },
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey[400]),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
                onSubmitted: (value) {
                  movieName = value;
                  if (movieName != '') {
                    _searchBloc.add(GetSearch(movieName, _page));
                  } else {
                    bottomFlushBar(context, "Type Movie Name");
                  }
                },
              ),
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25,
                  ),
                );
              }),
            ),
            body: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (!isLoadingNextPage &&
                    _scrollController.position.pixels ==
                        _scrollController.position.maxScrollExtent) {
                  setState(() {
                    isLoadingNextPage = true;
                    _page++;
                    _searchBloc.add(GetNextPageSearch(movieName, _page));
                  });
                }
                return true;
              },
              child: SafeArea(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return Center(child: Text("Type Movie Name"));
                    } else if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchError) {
                      return NoWifi(
                        onPressed: () {
                          _searchBloc.add(GetSearch(movieName, _page));
                        },
                      );
                    }
                    return movieSearchModel!.length == 0
                        ? Center(
                            child: Text(
                              'No Results',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.01),
                            controller: _scrollController,
                            itemCount: movieSearchModel!.length + 1,
                            itemBuilder: (context, index) {
                              if (index == movieSearchModel!.length) {
                                isLoadingNextPage = false;
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FeaturedScreen(
                                      id: movieSearchModel![index].id,
                                    );
                                  }));
                                },
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.04),
                                    child: Row(
                                      //   crossAxisAlignment: WrapCrossAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: orientation ==
                                                  Orientation.landscape
                                              ? screenHeight * 0.7
                                              : screenHeight * 0.22,
                                          width: screenWidth * 0.26,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: movieSearchModel![index]
                                                        .posterPath ==
                                                    null
                                                ? Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7RyB6wNXTa0DqKQeoBOoOu6_pqCbQmBqVQ&usqp=CAU'))
                                                : CachedNetworkImage(
                                                    fit: BoxFit.contain,
                                                    imageUrl: urlImage +
                                                        movieSearchModel![index]
                                                            .posterPath!,
                                                    placeholder:
                                                        (context, url) {
                                                      return Image(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              'images/placeholder_box.png'));
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Center(
                                                        child: Icon(Icons
                                                            .wifi_off_rounded),
                                                      );
                                                    },
                                                  ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: Text(
                                                movieSearchModel![index]
                                                            .title ==
                                                        null
                                                    ? 'No Name'
                                                    : movieSearchModel![index]
                                                        .title!,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Text(
                                                movieSearchModel![index]
                                                            .releaseDate ==
                                                        null
                                                    ? 'No ReleaseDate'
                                                    : movieSearchModel![index]
                                                        .releaseDate!,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white))
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text('Rating'),
                                            Text(
                                              '${movieSearchModel![index].voteAverage}/10',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              thickness: 2,
                            ),
                          );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
