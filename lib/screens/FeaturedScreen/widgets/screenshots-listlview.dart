import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Data/models/Screen-shots-model.dart';
import 'package:photo_view/photo_view.dart';

class ScreenShotsListView extends StatelessWidget {
  ScreenShotsListView({
    @required this.screenShots,
    @required this.urlImage,
  });

  final ScreenShots? screenShots;
  final String? urlImage;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Screen Shots',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          height: orientation == Orientation.landscape
              ? screenHeight * 0.4
              : screenHeight * 0.2,
          width: double.infinity,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 10, right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: screenShots!.backdrops!.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: screenWidth * 0.05,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ImageView(
                          image: urlImage! +
                              screenShots!.backdrops![index].filePath!,
                        );
                      });
                },
                child: Container(
                  width: orientation == Orientation.landscape
                      ? screenWidth * 0.4
                      : screenWidth * 0.6,
                  decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          blurRadius: 5,
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl:
                          urlImage! + screenShots!.backdrops![index].filePath!,
                      placeholder: (context, url) {
                        return Image(
                            fit: BoxFit.cover,
                            image: AssetImage('images/placeholder_cover.jpg'));
                      },
                      errorWidget: (context, url, error) {
                        return Icon(Icons.wifi_off_rounded);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ImageView extends StatelessWidget {
  const ImageView({
    Key? key,
    @required this.image,
  }) : super(key: key);

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: PhotoView(
            tightMode: true,
            imageProvider: NetworkImage(image!),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained,
            loadingBuilder: (context, event) => Center(
              child: Container(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  value: event == null
                      ? 0
                      : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
              )
            ]),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
