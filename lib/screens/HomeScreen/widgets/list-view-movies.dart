import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/constants.dart';
import 'package:movieapp/screens/FeaturedScreen/page/featured-screen.dart';

class ListViewMovies extends StatelessWidget {
  ListViewMovies({
    @required this.movieModel,
    @required this.urlImage,
    @required this.title,
    @required this.onTapSeeall,
  });

  final List<MovieResult>? movieModel;
  final String? urlImage;
  final String? title;
  final VoidCallback? onTapSeeall;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: kTextStyle,
                ),
                TextButton(
                  onPressed: onTapSeeall,
                  child: Text(
                    'See all',
                    style: kTextStyle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: orientation == Orientation.landscape
                ? screenHeight * 0.5
                : (screenHeight * 0.3),
            child: ListView.separated(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: movieModel!.length,
              itemBuilder: (BuildContext ctx, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return FeaturedScreen(
                        id: movieModel![index].id,
                      );
                    }));
                    print('tapped');
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: orientation == Orientation.landscape
                            ? screenWidth * 0.2
                            : screenWidth * 0.35,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                urlImage! + movieModel![index].posterPath!,
                            placeholder: (context, url) {
                              return Image(
                                  fit: BoxFit.cover,
                                  image:
                                      AssetImage('images/placeholder_box.png'));
                            },
                            errorWidget: (context, url, error) {
                              return Center(
                                  child: Icon(Icons.wifi_off_rounded));
                            },
                          ),
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
                              size: 12,
                            ),
                            SizedBox(width: 5),
                            Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                ),
                              ]),
                              child: Text(
                                movieModel![index]
                                        .voteAverage
                                        .toString()
                                        .substring(0, 3) +
                                    '/10',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 15,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
