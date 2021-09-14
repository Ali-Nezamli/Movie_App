import 'package:movieapp/Data/services/services.dart';

class Repository {
  Future getRecommend(int page) {
    var value = Services.getRecommend(page);
    print("Recommend $value");
    return value;
  }

  Future getPopular(int page) {
    var value = Services.getPopular(page);
    print("getPopular $value");
    return value;
  }

  Future getTopRated(int page) {
    var value = Services.getTopRated(page);
    print("getTopRated $value");
    return value;
  }

  Future getNowPlaying() {
    var value = Services.getNowPlaying();
    print("getNowPlaying $value");
    return value;
  }

  Future getDetails(int id) {
    var value = Services.getDetails(id);
    return value;
  }

  Future getSearch(String title, int page) {
    var value = Services.getSearch(title, page);
    return value;
  }

  Future getSimilerMovies(int page, int id) {
    var value = Services.getSimilerMovies(page, id);
    return value;
  }

  Future getCredits(int id) {
    var value = Services.getCredits(id);
    return value;
  }

  Future getScreenShots(int id) {
    var value = Services.getScreenShots(id);
    return value;
  }

  Future getVideos(int id) {
    var value = Services.getVideos(id);
    return value;
  }

  Future getLatestSeries(int page) {
    var value = Services.getLatestSeries(page);
    return value;
  }

  Future getPopularSeries(int page) {
    var value = Services.getPopularSeries(page);
    return value;
  }

  Future getTopRatedSeries(int page) {
    var value = Services.getTopRatedSeries(page);
    return value;
  }
}

class NetworkError extends Error {}
