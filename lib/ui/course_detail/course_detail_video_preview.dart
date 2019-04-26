
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class CourseDetailVideoPreview extends StatefulWidget {

  final String urlVideo;

  CourseDetailVideoPreview({
    Key key,
    @required this.urlVideo
  }) : super(key: key);

  @override
  _CourseDetailVideoPreviewState createState() => _CourseDetailVideoPreviewState();
}

class _CourseDetailVideoPreviewState extends State<CourseDetailVideoPreview> {

  FlutterYoutube youtube;
  String get urlVideo => urlVideo;

  @override
  void initState() {

    super.initState();
    youtube = FlutterYoutube();

  }


  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final cHeight = ( (width * 9) / 16 ); // 16:9
    
    return Container(

      width:  width,
      height: cHeight,

      alignment:  Alignment.center,
      decoration: BoxDecoration(

        image: DecorationImage(
          image: AssetImage('assets/video.jpg'),
          fit:   BoxFit.cover,
          colorFilter:  ColorFilter.mode(
            Colors.black26,
            BlendMode.darken
          )
        ),

      ),

  
      child: Material(
        color:        Colors.red,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          child: Container(
            width:  68.0,
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child:Icon(
              Icons.play_arrow,
              color: Colors.white,
              size:  36.0,
            )
          ),
          onTap: startVideoYouTube,

        )
      )
      
    );

  }


  dynamic startVideoYouTube() {

    return youtube.playYoutubeVideoByUrl(
      apiKey:     "AIzaSyAdPTF-t9WCnHOUB6zWxZK4RrBemOvgrMQ",
      videoUrl:   urlVideo,
      autoPlay:   true,
      fullScreen: false
    );

  }


}

