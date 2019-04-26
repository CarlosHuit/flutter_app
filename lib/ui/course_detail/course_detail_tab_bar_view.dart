
import 'package:app19022019/core/src/viewmodels/course_detail_view_model.dart';
import 'package:app19022019/ui/system-discussion/system_discussion.dart';
import 'package:flutter/material.dart';

class CourseDetailTabBarView extends StatelessWidget {

  final TabController tabController;
  final CourseDetailViewModel viewModel;

  const CourseDetailTabBarView({
    Key key,
    @required this.tabController,
    @required this.viewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        child: TabBarView(
          controller: tabController,
          children: <Widget>[
            CourseDetailView(viewModel: viewModel),
            SystemDiscussion(),
          ],
        ),
      ),
    );

  }

}


class CourseDetailView extends StatelessWidget {

  final CourseDetailViewModel viewModel;

  const CourseDetailView({Key key, this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final width = MediaQuery.of(context).size.width;
    final title = viewModel.course.title;
    final description = viewModel.course.description;
    final btnText = 'Empezer Curso';

    return Container(

      child: Column(
        children: <Widget>[

          Card(
            margin: EdgeInsets.all(10.0),
            child: Container(
 
              width:   width,
              padding: EdgeInsets.symmetric(
                vertical:   20.0,
                horizontal: 30.0
              ),
 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  
                  Text(
                    title,
                    style: TextStyle( fontWeight: FontWeight.bold, fontSize: 36.0 )
                  ),

                  Divider(),

                  Text(
                    description,
                    style: TextStyle( fontSize: 16.0 ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),

                  Center(

                    child:  RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                      color: Colors.red,
                      child: Text(
                        btnText,
                        style: TextStyle(
                          color:  Colors.white,
                          fontSize:  18.0,
                          fontWeight:  FontWeight.bold,
                          letterSpacing: 0.4
                        ),
                      ),
                      onPressed: viewModel.startCourse,

                    ),

                  )

                ],
              ),
            ),
          ),

        ],
      ),

    );


  }
}


