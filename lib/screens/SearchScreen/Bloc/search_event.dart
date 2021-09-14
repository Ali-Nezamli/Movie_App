part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class GetSearch extends SearchEvent {
  final String movieTitle;
  final int page;

  GetSearch(this.movieTitle, this.page);
}

class GetNextPageSearch extends SearchEvent {
  final String movieTitle;
  final int page;

  GetNextPageSearch(this.movieTitle, this.page);
}
