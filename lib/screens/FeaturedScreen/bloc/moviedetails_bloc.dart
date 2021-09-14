import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/Data/Repository/repository.dart';
import 'package:movieapp/Data/models/Screen-shots-model.dart';
import 'package:movieapp/Data/models/credits-model.dart';
import 'package:movieapp/Data/models/details-modal.dart';
import 'package:movieapp/Data/models/video-model.dart';
part 'moviedetails_event.dart';
part 'moviedetails_state.dart';

class MoviedetailsBloc extends Bloc<MoviedetailsEvent, MoviedetailsState> {
  Repository _repository = Repository();
  MoviedetailsBloc() : super(MoviedetailsInitial());

  MoviedetailsState get initalState => MoviedetailsInitial();

  @override
  Stream<MoviedetailsState> mapEventToState(
    MoviedetailsEvent event,
  ) async* {
    try {
      if (event is GetMovieDetails) {
        yield MoviedetailsLoading();
        final dataDetails = await _repository.getDetails(event.movieId);
        final dataCredits = await _repository.getCredits(event.movieId);
        final dataScreenShots = await _repository.getScreenShots(event.movieId);
        final dataVideos = await _repository.getVideos(event.movieId);
        final dataSimiler =
            await _repository.getSimilerMovies(1, event.movieId);
        if (dataDetails != null &&
            dataCredits != null &&
            dataScreenShots != null &&
            dataSimiler != null) {
          print(dataDetails);
          yield MoviedetailsLoaded(dataDetails, dataCredits, dataScreenShots,
              dataVideos, dataSimiler);
        } else {
          yield MoviedetailsError();
        }
      }
    } on NetworkError {
      yield MoviedetailsError();
    }
  }
}
