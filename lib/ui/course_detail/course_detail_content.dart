import 'package:flutter/material.dart';
import 'package:app19022019/core/src/viewmodels/course_detail_view_model.dart';
import './course_detail_tab_bar.dart';
import './course_detail_video_preview.dart';
import './course_detail_tab_bar_view.dart';

class CourseDetailContent extends StatefulWidget {

  final CourseDetailViewModel viewModel;

  CourseDetailContent({ Key key, @required this.viewModel }) : super(key: key);

  @override
  _CourseDetailContentState createState() => _CourseDetailContentState();
}

class _CourseDetailContentState extends State<CourseDetailContent> with SingleTickerProviderStateMixin {

  TabController tabController;
  CourseDetailViewModel get viewModel => widget.viewModel;


  @override
  void initState() {

    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }


  @override
  void dispose() {

    tabController.dispose();
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar( title: Text('Detalles del curso'), centerTitle: true ),
      body: Container(

        color: Colors.grey[100],
        child: Column(
          children: <Widget>[

            CourseDetailVideoPreview(
              urlVideo: viewModel.course.urlVideo,
            ),

            Expanded(

              child: Container(
                child: Column(
                  children: <Widget>[

                    CourseDetailTabBar(
                      tabController: tabController
                    ),

                    CourseDetailTabBarView(
                      tabController: tabController,
                      viewModel: viewModel
                    )

                  ],
                )
              ),

            )

          ],
        )

      )
    );


  }

}

