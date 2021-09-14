// To parse this JSON data, do
//
//     final screenShots = screenShotsFromJson(jsonString);

import 'dart:convert';

ScreenShots screenShotsFromJson(String str) =>
    ScreenShots.fromJson(json.decode(str));

String screenShotsToJson(ScreenShots data) => json.encode(data.toJson());

class ScreenShots {
  ScreenShots({
    this.id,
    this.backdrops,
    this.posters,
  });

  int? id;
  List<Backdrop>? backdrops;
  List<Backdrop>? posters;

  factory ScreenShots.fromJson(Map<String, dynamic> json) => ScreenShots(
        id: json["id"],
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromJson(x))),
        posters: List<Backdrop>.from(
            json["posters"].map((x) => Backdrop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "backdrops": List<dynamic>.from(backdrops!.map((x) => x.toJson())),
        "posters": List<dynamic>.from(posters!.map((x) => x.toJson())),
      };
}

class Backdrop {
  Backdrop({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  double? aspectRatio;
  String? filePath;
  int? height;
  String? iso6391;
  double? voteAverage;
  int? voteCount;
  int? width;

  factory Backdrop.fromJson(Map<String, dynamic> json) => Backdrop(
        aspectRatio: json["aspect_ratio"].toDouble(),
        filePath: json["file_path"],
        height: json["height"],
        iso6391: json["iso_639_1"] == null ? null : json["iso_639_1"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "aspect_ratio": aspectRatio,
        "file_path": filePath,
        "height": height,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "width": width,
      };
}
