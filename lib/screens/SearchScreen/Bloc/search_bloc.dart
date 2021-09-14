import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/Data/Repository/repository.dart';
import 'package:movieapp/Data/models/movie-model.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Repository _repository = Repository();
  SearchBloc() : super(SearchInitial());

  SearchState get initialState => SearchInitial();

  List<MovieResult>? dataSearch = [];

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is GetSearch) {
      try {
        yield SearchLoading();
        dataSearch = [];
        dataSearch = await _repository.getSearch(event.movieTitle, event.page);
        if (dataSearch != null) {
          yield SearchLoaded(dataSearch);
        } else {
          yield SearchError();
        }
      } on NetworkError {
        yield SearchError();
      }
    }
    if (event is GetNextPageSearch) {
      try {
        dataSearch = dataSearch! +
            await _repository.getSearch(event.movieTitle, event.page);
        if (dataSearch != null) {
          yield SearchLoaded(dataSearch);
        } else {
          yield SearchError();
        }
      } on NetworkError {
        yield SearchError();
      }
    }
  }
}
