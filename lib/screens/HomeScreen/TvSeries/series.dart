import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Data/models/series-model.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/bloc/series_bloc.dart';
import 'package:movieapp/screens/HomeScreen/TvSeries/list-view-series.dart';
import 'package:movieapp/screens/Widgets/no-wifi.dart';

class TvSeries extends StatefulWidget {
  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  var urlImage = 'https://image.tmdb.org/t/p/w500';
  final SeriesBloc seriesBloc = SeriesBloc();
  List<SeriesResult>? latestModal;
  List<SeriesResult>? popularModel;
  List<SeriesResult>? topRatedModel;
  bool isLoadingNextPage = false;

  @override
  void initState() {
    super.initState();
    seriesBloc.add(GetSeries(1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesBloc, SeriesState>(
      bloc: seriesBloc,
      builder: (context, state) {
        if (state is SeriesInitial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is Loaded) {
          latestModal = state.dataLatest;
          popularModel = state.dataPopular;
          topRatedModel = state.dataTopRated;
        } else if (state is Error) {
          return Center(
            child: NoWifi(
              onPressed: () {
                seriesBloc.add(GetSeries(1));
              },
            ),
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                ListViewSeries(
                  bloc: seriesBloc,
                  model: latestModal,
                  urlImage: urlImage,
                  title: 'Latest',
                ),
                ListViewSeries(
                  model: popularModel,
                  urlImage: urlImage,
                  title: "Popular",
                ),
                ListViewSeries(
                  model: topRatedModel,
                  urlImage: urlImage,
                  title: "Top Rated",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
