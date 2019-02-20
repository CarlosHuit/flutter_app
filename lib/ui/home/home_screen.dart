import 'package:app19022019/ui/components/drawer/drawer.dart';
import 'package:app19022019/ui/home/home_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatelessWidget {

  final OnBackPressed onBackPressed = OnBackPressed();

  @override
  Widget build(BuildContext context) {

    showStatusBar(color: Colors.black12);

    return WillPopScope(
      onWillPop: () => onBackPressed.validation(context),
      child: Scaffold(
        appBar: homeAppBar(),
        drawer: myDrawer(context),
        body:   Container(
          alignment: Alignment.center,
          child: Container(
            child: Text('Hello world'),
          ),
        )
      )
    );
  }

  Future showStatusBar({@required Color color}) {

    return Future.delayed(Duration(milliseconds: 200), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle( statusBarColor: color)
      );
    });

  }
}