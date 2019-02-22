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
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: viewModel.courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      
                      contentPadding: EdgeInsets.symmetric(
                        vertical:   12.0,
                        horizontal: 15.0
                      ),
                      title: Text(
                        viewModel.courses[index].title,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'
                        ),
                      ),
                      leading: Image.asset(
                        'assets/${viewModel.courses[index].title.toLowerCase()}-min.png',
                        height: 65.0,
                        width: 65.0
                      ),
                      onTap: () => print('hello'),
                    );
                  },
                ),
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

  void hideStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle( statusBarColor: Colors.transparent )
    );
  }

}