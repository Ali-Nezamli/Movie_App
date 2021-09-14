part of 'Movie_bloc.dart';

@immutable
abstract class MoviesEvent {
  const MoviesEvent();
}

class GetMovies extends MoviesEvent {
  final int page;

  GetMovies(this.page);
}

class GetNextPageRecommend extends MoviesEvent {
  final int page;

  GetNextPageRecommend(this.page);
}

class GetNextPagePopular extends MoviesEvent {
  final int page;

  GetNextPagePopular(this.page);
}

class GetNextPageTopRated extends MoviesEvent {
  final int page;

  GetNextPageTopRated(this.page);
}

class GetNextPageSimilar extends MoviesEvent {
  final int page;
  final int id;

  GetNextPageSimilar(this.page, this.id);
}
