class Video {
  String? thumbnail;
  String? url;

  Video({this.thumbnail, this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      thumbnail: json["thumbnail"],
      url: json["url"],
    );
  }
}
