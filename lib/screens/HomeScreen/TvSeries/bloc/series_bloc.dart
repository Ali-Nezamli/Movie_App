import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/Data/Repository/repository.dart';
import 'package:movieapp/Data/models/series-model.dart';
part 'series_event.dart';
part 'series_state.dart';

class SeriesBloc extends Bloc<SeriesEvent, SeriesState> {
  final Repository _repository = Repository();
  SeriesBloc() : super(SeriesInitial());

  SeriesState get initialState => SeriesInitial();
  List<SeriesResult>? dataLatest = [];
  List<SeriesResult>? dataPopular = [];
  List<SeriesResult>? dataTopRated = [];
  @override
  Stream<SeriesState> mapEventToState(
    SeriesEvent event,
  ) async* {
    try {
      if (event is GetSeries) {
        yield Loading();
        dataLatest = await _repository.getLatestSeries(event.page);
        dataPopular = await _repository.getPopularSeries(event.page);
        dataTopRated = await _repository.getTopRatedSeries(event.page);
        if (dataLatest != null && dataPopular != null && dataTopRated != null) {
          yield Loaded(dataLatest, dataPopular, dataTopRated);
        } else
          yield Error();
      }
    } on NetworkError {
      yield Error();
    }
  }
}
