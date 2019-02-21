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

    showStatusBar(color: Colors.black12);
    return StoreConnector<AppState, HomeViewModel>(
      distinct: true,
      converter: (store) => HomeViewModel.fromStore(store: store),
      builder: (_, viewModel) {

        return WillPopScope(
          onWillPop: () => onBackPressed.validation(context),
          child: Scaffold(
            appBar: homeAppBar(),
            drawer: myDrawer(context, viewModel),
            body:   Container(
              alignment: Alignment.center,
              child: Container(
                child: Text(viewModel.fullName()),
              ),
            )
          )
        );

      },
    );
  }

  Future showStatusBar({@required Color color}) {

    return Future.delayed(Duration(milliseconds: 500), () {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle( statusBarColor: color)
      );
    });

  }
}