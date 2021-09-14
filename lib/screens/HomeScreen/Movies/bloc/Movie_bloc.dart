import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/Data/Repository/repository.dart';
import 'package:movieapp/Data/models/movie-model.dart';
part 'Movie_event.dart';
part 'Movie_state.dart';

class MovieBloc extends Bloc<MoviesEvent, MovieState> {
  final Repository _repository = Repository();
  MovieBloc() : super(MovieInitial());

  MovieState get initialState => MovieInitial();

  List<MovieResult>? dataRecommend = [];
  List<MovieResult>? dataPopular = [];
  List<MovieResult>? dataTopRated = [];
  List<MovieResult>? dataNowPlaying = [];
  @override
  Stream<MovieState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is GetMovies) {
      try {
        yield MovieLoading();
        dataRecommend = await _repository.getRecommend(event.page);
        dataPopular = await _repository.getPopular(event.page);
        dataTopRated = await _repository.getTopRated(event.page);
        dataNowPlaying = await _repository.getNowPlaying();
        if (dataRecommend != null &&
            dataPopular != null &&
            dataTopRated != null &&
            dataNowPlaying != null) {
          yield MovieLoaded(
              dataRecommend, dataPopular, dataTopRated, dataNowPlaying);
        } else {
          yield MovieError();
        }
      } on NetworkError {
        yield MovieError();
      }
    }
    if (event is GetNextPageRecommend) {
      try {
        dataRecommend =
            dataRecommend! + await _repository.getRecommend(event.page);

        if (dataRecommend != null) {
          yield Movieloaded(
            dataRecommend,
          );
        } else {
          yield MovieError();
        }
      } on NetworkError {
        yield MovieError();
      }
    }
    if (event is GetNextPagePopular) {
      try {
        dataPopular = dataPopular! + await _repository.getPopular(event.page);

        if (dataPopular != null) {
          yield Movieloaded(
            dataPopular,
          );
        } else {
          yield MovieError();
        }
      } on NetworkError {
        yield MovieError();
      }
    }
    if (event is GetNextPageTopRated) {
      try {
        dataTopRated =
            dataTopRated! + await _repository.getTopRated(event.page);

        if (dataPopular != null) {
          yield Movieloaded(
            dataTopRated,
          );
        } else {
          yield MovieError();
        }
      } on NetworkError {
        yield MovieError();
      }
    }
    if (event is GetNextPageSimilar) {
      try {
        dataTopRated = dataTopRated! +
            await _repository.getSimilerMovies(event.page, event.id);

        if (dataPopular != null) {
          yield Movieloaded(
            dataTopRated,
          );
        } else {
          yield MovieError();
        }
      } on NetworkError {
        yield MovieError();
      }
    }
  }
}
