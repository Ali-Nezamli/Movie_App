part of 'series_bloc.dart';

@immutable
abstract class SeriesEvent {}

class GetSeries extends SeriesEvent {
  final int page;

  GetSeries(this.page);
}
