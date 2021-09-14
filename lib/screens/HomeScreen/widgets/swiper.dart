import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/screens/FeaturedScreen/page/featured-screen.dart';

class SwiperImages extends StatelessWidget {
  final List<MovieResult>? nowPlayingModel;
  final String? urlImage;

  SwiperImages({this.nowPlayingModel, this.urlImage});

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Swiper(
            loop: true,
            duration: 1000,
            viewportFraction: orientation == Orientation.landscape ? 0.22 : 0.5,
            scale: 0.5,
            onTap: (index) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FeaturedScreen(
                  id: nowPlayingModel![index].id,
                );
              }));
              print('tapped');
            },
            itemCount: nowPlayingModel!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = nowPlayingModel![index].posterPath == null
                  ? Center(child: Text('No Image'))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl:
                            urlImage! + nowPlayingModel![index].posterPath!,
                        placeholder: (context, url) {
                          return Image(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('images/placeholder_cover.jpg'));
                        },
                        errorWidget: (context, url, error) {
                          return Center(
                            child: Icon(
                              Icons.wifi_off_rounded,
                            ),
                          );
                        },
                      ),
                    );

              return data;
            },
            curve: Curves.easeIn,
          ),
          Container(
            height: 25,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 15,
                spreadRadius: 10,
              ),
            ]),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              'Now In Theaters',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 10,
            child: Text(
              'Now In Theaters',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
