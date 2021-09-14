part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final dataSearch;

  SearchLoaded(this.dataSearch);
}

class NextSearchLoaded extends SearchState {
  final dataSearch;

  NextSearchLoaded(this.dataSearch);
}

class SearchError extends SearchState {}
