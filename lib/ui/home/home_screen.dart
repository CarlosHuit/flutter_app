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
        return WillPopScope(
          onWillPop: () => onBackPressed.validation(context),
          child: Scaffold(
            appBar: homeAppBar(),
            drawer: myDrawer(context, viewModel),
            body:   Container(
              alignment: Alignment.center,
              child: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color:     Colors.black,
                      textColor: Colors.white,
                      onPressed: () => showStatusBar(),
                      child:     Text(
                        'ShowStatusBar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    RaisedButton(
                      color:     Colors.red,
                      textColor: Colors.white,
                      onPressed: () => hideStatusBar(),
                      child:     Text(
                        'HideStatusBar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
              ),
            )
          )
        );

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