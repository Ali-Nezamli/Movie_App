part of 'moviedetails_bloc.dart';

@immutable
abstract class MoviedetailsState {}

class MoviedetailsInitial extends MoviedetailsState {}

class MoviedetailsLoading extends MoviedetailsState {}

class MoviedetailsLoaded extends MoviedetailsState {
  final DetailsModel dataDetails;
  final CreditsModel dataCredits;
  final ScreenShots dataScreenShots;
  final VideosModel datavideoModel;
  final dataSimiler;

  MoviedetailsLoaded(this.dataDetails, this.dataCredits, this.dataScreenShots,
      this.datavideoModel, this.dataSimiler);
}

class MoviedetailsError extends MoviedetailsState {}
