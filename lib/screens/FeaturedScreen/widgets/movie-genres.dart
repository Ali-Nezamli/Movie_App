import 'package:flutter/material.dart';
import 'package:movieapp/Data/models/details-modal.dart';

class MovieGenres extends StatelessWidget {
  MovieGenres({
    @required this.detailsModel,
  });

  final DetailsModel? detailsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Center(
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: detailsModel!.genres!.length,
          separatorBuilder: (BuildContext context, int index) => SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
          itemBuilder: (context, int index) {
            return Container(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  detailsModel!.genres![index].name!,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
