import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/Data/models/credits-model.dart';

class CastListView extends StatelessWidget {
  CastListView({
    @required this.creditsModel,
    @required this.urlImage,
  });

  final CreditsModel? creditsModel;
  final String? urlImage;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Cast',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: orientation == Orientation.landscape
                  ? screenHeight * 0.3
                  : screenHeight * 0.21,
              minHeight: 56.0),
          child: ListView.separated(
            padding: EdgeInsets.only(left: 10, right: 10),
            scrollDirection: Axis.horizontal,
            itemCount: creditsModel!.cast!.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Container(
                    height: 130,
                    width: 130,
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    child: Container(
                      height: 110,
                      width: 110,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: creditsModel!.cast![index].profilePath !=
                                  null
                              ? urlImage! +
                                  creditsModel!.cast![index].profilePath!
                              : "https://www.google.nl/url?sa=i&url=https%3A%2F%2Fhomey.app%2Fen-us%2Faccount%2F&psig=AOvVaw3V9sP61nHkiF0yHWO48cQS&ust=1624264645204000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCKiTpJWzo_ECFQAAAAAdAAAAABAQ",
                          placeholder: (context, url) {
                            return Image(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('images/placeholder_cover.jpg'));
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset('images/download.png');
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        creditsModel!.cast![index].name!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
