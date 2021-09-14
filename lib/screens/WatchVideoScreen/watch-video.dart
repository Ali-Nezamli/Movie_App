import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WatchVideo extends StatefulWidget {
  final id;
  final String? image;

  WatchVideo({@required this.id, @required this.image});

  @override
  _WatchVideoState createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  YoutubePlayerController? _controller;
  var urlImage = 'https://image.tmdb.org/t/p/original';
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: '${widget.id}',
      params: YoutubePlayerParams(
        showFullscreenButton: true,
        autoPlay: true,
        showControls: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              size: 25,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: urlImage + widget.image!,
                placeholder: (context, url) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueGrey,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(Icons.error);
                },
              ),
            ),
          ),
          Center(
              child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 15)
                  ]),
                  height: 70,
                  width: 70,
                  child: CircularProgressIndicator())),
          Container(
            child: Center(
              child: YoutubePlayerIFrame(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
