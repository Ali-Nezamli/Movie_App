part of 'series_bloc.dart';

@immutable
abstract class SeriesState {}

class SeriesInitial extends SeriesState {}

class Loading extends SeriesState {}

class LoadingNextPage extends SeriesState {}

class Loaded extends SeriesState {
  final dataLatest;
  final dataPopular;
  final dataTopRated;

  Loaded(this.dataLatest, this.dataPopular, this.dataTopRated);
}

class LoadedLatestSeries extends SeriesState {
  final dataLatest;

  LoadedLatestSeries(this.dataLatest);
}

class LoadedPopularSeries extends SeriesState {
  final dataPopular;

  LoadedPopularSeries(this.dataPopular);
}

class LoadedTopRatedSeries extends SeriesState {
  final dataTopRated;

  LoadedTopRatedSeries(this.dataTopRated);
}

class Error extends SeriesState {}
