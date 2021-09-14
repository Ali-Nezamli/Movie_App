part of 'moviedetails_bloc.dart';

@immutable
abstract class MoviedetailsEvent {}

class GetMovieDetails extends MoviedetailsEvent {
  final int movieId;

  GetMovieDetails(this.movieId);
}
