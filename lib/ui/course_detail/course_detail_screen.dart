
import 'package:app19022019/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_youtube/flutter_youtube.dart';


class CourseDetailScree extends StatefulWidget {
  @override
  _CourseDetailScreeState createState() => _CourseDetailScreeState();
}

class _CourseDetailScreeState extends State<CourseDetailScree> with SingleTickerProviderStateMixin {

  final FlutterYoutube youtube =  FlutterYoutube();
  TabController tabController;

  @override
  void initState() {

    tabController = TabController(length: 2, vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  


  @override
  Widget build(BuildContext context) {

    return StoreConnector<AppState, CourseDetailViewModel>(
      distinct:  true,
      onDispose: (store) => store.dispatch(UnsetCurrentCourse()),
      converter: (store) => CourseDetailViewModel.fromStore(store: store),
      builder:   (_, viewModel) {



        return Scaffold(
          appBar: AppBar(
            title:       Text('Detalle del Curso'),
            centerTitle: true
          ),
          body:   Container(

            color: Colors.grey[100],
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[

                  fakeVideoContainer(context, viewModel.course.urlVideo),
                  tabsCourseDetail(context: context, viewModel: viewModel),

                ],
              )
            )

          )
        );



      },
    );


  }


  Widget fakeVideoContainer(BuildContext context, String videoUrl) {

    final size = MediaQuery.of(context).size;
    
    return Container(
      width: size.width,
      height: (size.width * 9) / 16,

      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/video.jpg'),
          fit:   BoxFit.cover,
          colorFilter:  ColorFilter.mode(Colors.black26, BlendMode.darken )
        ),
      ),

      alignment: Alignment.center,

      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          child: Container(
            width:  48.0,
            height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child:Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 36.0,
            )
          ),
          onTap: () => startVideoYouTube(youtube: youtube, videoUrl: videoUrl),

        )
      )
      
    );
  }


  Widget tabBar() {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: TabBar(
        indicatorColor: Colors.red,
        indicatorWeight: 4.0,
        controller: tabController,
        tabs: <Widget>[
          Tab(
            child: Text(
              'Detalles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            )
          ),

          Tab(
            child: Text(
              'Comentarios',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0
              ),
            ),),
        ],
      ),

    );

  }



  Widget tabBarView({
    @required BuildContext context,
    @required CourseDetailViewModel viewModel
  }) {

    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height - ((size.width * 9) / 16) - 130,
      constraints: BoxConstraints( minHeight: 250.0 ),
      child:       TabBarView(
        controller: tabController,
        children:   <Widget>[

          SingleChildScrollView(

            child: Column(
              children: <Widget>[
                cardCourseDetail(context: context, viewModel: viewModel),
              ],
            ),

          ),

          SingleChildScrollView(

            child: Column(
              children: <Widget>[
                comments(context),
              ],
            ),

          ),

        ],
      ),
    );
  }



  Widget tabsCourseDetail({
    @required BuildContext context,
    @required CourseDetailViewModel viewModel
  }) {

    return Container(
      child: Column(
        children: <Widget>[

          tabBar(),
          tabBarView(context: context, viewModel: viewModel)

        ],
      ),
    );
  }

  Widget cardCourseDetail({
    @required BuildContext context,
    @required CourseDetailViewModel viewModel
  }) {

    final size =MediaQuery.of(context).size;

    return Container(
      width: size.width,
      margin: EdgeInsets.all(5.0),
      child:  Card(

        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Container(
                child: Text(
                  '${viewModel.course.title}',
                  style: TextStyle( fontWeight: FontWeight.bold, fontSize: 36.0 ),  
                ),
              ),

              Divider(),

              Container(
                child: Text(
                  '${viewModel.course.description}',
                  style: TextStyle( fontSize: 16.0 ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin:    EdgeInsets.only(top: 20.0),
                child: Container(


                  width: 200.0,
                  height: 40.0,
                  child:  RaisedButton(

                    color: Colors.red,
                    child: Text(
                      'Empezar Curso',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:      Colors.white,
                        fontSize:   18.0
                      ),
                    ),
                    onPressed: () => viewModel.startCourse(viewModel.course.subtitle),

                  ),


                ),
              )

            ],
          ),
        )

      )

    );
  }



  dynamic startVideoYouTube({
    @required FlutterYoutube youtube,
    @required String videoUrl
  }) {

    // final FlutterYoutube youtube =  FlutterYoutube();

    return youtube.playYoutubeVideoByUrl(
      apiKey:     "AIzaSyAdPTF-t9WCnHOUB6zWxZK4RrBemOvgrMQ",
      videoUrl:   videoUrl,
      autoPlay:   true,
      fullScreen: false
    );

  }



  Widget comments(BuildContext context) {

    final size =MediaQuery.of(context).size;


    return Container(
      width: size.width,
      margin: EdgeInsets.all(5.0),
      child:  Card(

        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[

              Text(
                'Comments Section',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 10.0,),
              Icon(
                Icons.message,
                color: Colors.grey,
                size: 48.0,
              )

            ],
          ),
        )

      )

    );

  }

}






