class Course {


  String id;
  String title;
  String subtitle;
  String imageUrl;
  String urlVideo;
  String description;


  Course(Map<String, dynamic> course) {
    id          = course['_id'];
    title       = course['title'];
    subtitle    = course['subtitle'];
    imageUrl    = course['imageUrl'];
    urlVideo    = course['urlVideo'];
    description = course['description'];
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
