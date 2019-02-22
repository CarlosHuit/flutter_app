import 'package:app19022019/core/core.dart';
import 'package:app19022019/ui/components/drawer/drawer.dart';
import 'package:app19022019/ui/home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {

  final OnBackPressed onBackPressed = OnBackPressed();

  @override
  Widget build(BuildContext context) {



    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      onDispose: (store) => print('disposeHome'),
      converter: (store) => HomeViewModel.fromStore(store: store),
      builder: (_, viewModel) {
        showStatusBar();

        if (viewModel.courses.length > 0) {

          return WillPopScope(
            onWillPop: () => onBackPressed.validation(context),
            child: Scaffold(
              appBar: homeAppBar(),
              drawer: myDrawer(context, viewModel),
              body:   Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[100],
                child: Column(
                  children: coursesList(viewModel, context)
                )
              ),
            )
          );

        } else {

          return WillPopScope(
            onWillPop: () => onBackPressed.validation(context),
            child: Scaffold(
              appBar: homeAppBar(),
              drawer: myDrawer(context, viewModel),
              body:   Container(
                padding:   EdgeInsets.only(top: 10.0),
                alignment: Alignment.topCenter,
                child:     CircularProgressIndicator(),
              )
            )
          );

        }

      },
    );
  }

  void showStatusBar() {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle( statusBarColor: Colors.black12 )
    );

  }

  Widget itemCourse({ @required BuildContext context, @required Course course }) {
    return Container(

      width:  MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      height: 80.0,
      child: Card(
        margin: EdgeInsets.all(0),
        child:InkWell(
          onTap: () => print(course.title),
          child: Row(
            children: <Widget>[

              Container(
                width:     80.0,
                height:    80.0,
                margin:    EdgeInsets.only(left: 5.0),
                alignment: Alignment.center,
                child:     Image.asset(
                  'assets/${course.title.toLowerCase()}-min.png',
                  height: 65.0,
                  width: 65.0
                ),
              ),

              Expanded(
                child: Container(
                  height:    80.0,
                  margin:    EdgeInsets.only(left: 10.0),
                  alignment: Alignment.centerLeft,
                  child:     Text(

                    course.title,
                    overflow: TextOverflow.ellipsis,
                    style:    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:   28.0,
                      fontFamily: 'Roboto'
                    ),

                  ),
                ),
              ),

              Container(
                width:     40.0,
                height:    80.0,
                margin:    EdgeInsets.symmetric(horizontal: 10.0),
                alignment: Alignment.centerRight,
              )

            ],
          ),

        )
      ),
    );
  }

  List<Widget> coursesList(HomeViewModel viewModel, BuildContext context) {

    List<Widget> courses = [];

    for (var i = 0; i < viewModel.courses.length; i++) {
      final Course course = viewModel.courses[i];
      courses.add(itemCourse(context: context, course: course));
    }

    return courses;
  }

}