import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Data/models/series-model.dart';
import 'package:movieapp/constants.dart';

class ListViewSeries extends StatefulWidget {
  ListViewSeries({
    @required this.model,
    @required this.urlImage,
    @required this.title,
    this.bloc,
  });

  final List<SeriesResult>? model;
  final String? urlImage;
  final String? title;
  final bloc;

  @override
  _ListViewSeriesState createState() => _ListViewSeriesState();
}

class _ListViewSeriesState extends State<ListViewSeries> {
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15, vertical: screenHeight * 0.02),
            child: Row(
              children: [
                Text(
                  widget.title!,
                  style: kTextStyle,
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
              controller: _scrollController,
              itemCount: widget.model!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Stack(
                  children: [
                    Container(
                      width: orientation == Orientation.landscape
                          ? screenWidth * 0.2
                          : screenWidth * 0.35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: widget.model![index].posterPath == null
                            ? Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY7RyB6wNXTa0DqKQeoBOoOu6_pqCbQmBqVQ&usqp=CAU'))
                            : CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: widget.urlImage! +
                                    widget.model![index].posterPath!,
                                placeholder: (context, url) {
                                  return Image(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'images/placeholder_box.png'));
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
                              widget.model![index].voteAverage.toString() +
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
