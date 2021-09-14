import 'package:http/http.dart' as http;
import 'package:movieapp/Data/models/Screen-shots-model.dart';
import 'package:movieapp/Data/models/credits-model.dart';
import 'package:movieapp/Data/models/details-modal.dart';
import 'package:movieapp/Data/models/movie-model.dart';
import 'package:movieapp/Data/models/series-model.dart';
import 'package:movieapp/Data/models/video-model.dart';

class Services {
  static var baseUrl = 'https://api.themoviedb.org/3';
  static var apiKey = '418c7bc175247a5dbb0bface4f2d8d74';

  static Future getPopular(int page) async {
    var url = Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);

          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getTopRated(int page) async {
    var url = Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey&page=$page');
    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getRecommend(int page) async {
    var url = Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey&page=$page');
    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);

          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getNowPlaying() async {
    var url = Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);

          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<ScreenShots?> getScreenShots(
    int id,
  ) async {
    var url = Uri.parse('$baseUrl/movie/$id/images?api_key=$apiKey');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = screenShotsFromJson(response.body);
          return data;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CreditsModel?> getCredits(
    int id,
  ) async {
    var url = Uri.parse('$baseUrl/movie/$id/credits?api_key=$apiKey');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = creditsModelFromJson(response.body);
          return data;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<DetailsModel?> getDetails(
    int id,
  ) async {
    var url = Uri.parse('$baseUrl/movie/$id?api_key=$apiKey');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = detailsModelFromJson(response.body);
          return data;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getSimilerMovies(
    int page,
    int id,
  ) async {
    var url =
        Uri.parse('$baseUrl/movie/$id/similar?api_key=$apiKey&page=$page');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<VideosModel?> getVideos(
    int id,
  ) async {
    var url = Uri.parse('$baseUrl/movie/$id/videos?api_key=$apiKey');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = videosModelFromJson(response.body);
          return data;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getSearch(String title, int page) async {
    var url = Uri.parse(
        '$baseUrl/search/movie?api_key=$apiKey&language=en-US&query=$title&page=$page&include_adult=false');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = movieModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getTopRatedSeries(int page) async {
    var url =
        Uri.parse('$baseUrl/tv/top_rated?api_key=$apiKey&language=en-US$page');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = seriesModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getPopularSeries(int page) async {
    var url =
        Uri.parse('$baseUrl/tv/popular?api_key=$apiKey&language=en-US$page');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = seriesModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future getLatestSeries(int page) async {
    var url = Uri.parse(
        '$baseUrl/tv/airing_today?api_key=$apiKey&language=en-US&language=en-US&page=$page');

    try {
      var response = await http.get(url).timeout(Duration(seconds: 30));
      switch (response.statusCode) {
        case 200:
          var data = seriesModelFromJson(response.body);
          return data.results;

        default:
          return null;
      }
    } catch (e) {
      return null;
    }
  }
}
