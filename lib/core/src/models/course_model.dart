import 'package:meta/meta.dart';

class Course {


  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String urlVideo;
  final String description;

  Course({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.imageUrl,
    @required this.urlVideo,
    @required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {

    return Course(
      id:          json['id'],
      title:       json['title'],
      subtitle:    json['subtitle'],
      imageUrl:    json['imageUrl'],
      urlVideo:    json['urlVideo'],
      description: json['description'],

    );

  }

  Map<String, String> toJson() => {
    id:          id,
    title:       title,
    subtitle:    subtitle,
    imageUrl:    imageUrl,
    urlVideo:    urlVideo,
    description: description
  };

}
