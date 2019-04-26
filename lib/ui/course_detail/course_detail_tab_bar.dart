import 'package:flutter/material.dart';

class CourseDetailTabBar extends StatelessWidget {

  final TabController tabController;

  const CourseDetailTabBar({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18.0
    );

    return Container(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: TabBar(
        controller:      tabController,
        indicatorColor:  Colors.red,
        indicatorWeight: 4.0,
        tabs: <Widget>[
          
          Tab( child: Text( 'Detalles',    style: textStyle ) ),
          Tab( child: Text( 'Comentarios', style: textStyle ) ),

        ],
      ),

    );

  }
  
}


