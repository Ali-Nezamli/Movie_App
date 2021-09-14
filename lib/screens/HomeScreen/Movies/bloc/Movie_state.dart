part of 'Movie_bloc.dart';

@immutable
abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final dataRecommend;
  final dataPopular;
  final dataTopRated;
  final dataNowPlaying;

  MovieLoaded(
    this.dataRecommend,
    this.dataPopular,
    this.dataTopRated,
    this.dataNowPlaying,
  );
}

class LoadingRecommend extends MovieState {}

class Movieloaded extends MovieState {
  final dataRecommend;

  Movieloaded(
    this.dataRecommend,
  );
}

class MovieError extends MovieState {}
