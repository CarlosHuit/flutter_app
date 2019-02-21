import 'package:app19022019/core/core.dart';
import 'package:app19022019/ui/not_found/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import './auth/login/login_screen.dart';
import './auth/signup/signup_screen.dart';
import './home/home_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';

final Map<String, WidgetBuilder> routes = {
  '/home':   (context) => HomeScreen(),
  '/signin': (context) => LoginScreen(),
  '/signup': (context) => SignupScreen()
};



class App extends StatefulWidget {

  final Store<AppState> store;
  const App({ Key key, @required this.store }) : super(key: key);

  @override
  _AppState createState() => _AppState();

}



class _AppState extends State<App> {

  Store get store => widget.store;

  @override
  Widget build(BuildContext context) {

    return StoreProvider<AppState>(


      store: store,
      child: StoreConnector<AppState, AppViewModel>(

        distinct: true,
        converter: (store) => AppViewModel.fromStore(store),
        builder: (_, viewModel) {


          return MaterialApp(
            title:        'WeLearn',
            theme:        ThemeData(

              hintColor:  Colors.white,
              errorColor: Colors.orange,
              fontFamily: 'Roboto'

            ),
            home:         viewModel.isLoggedIn ? HomeScreen() :LoginScreen(),
            routes:       routes,
            navigatorKey: NavigationKey.key,
            debugShowCheckedModeBanner: false,
            onUnknownRoute: (RouteSettings settings) {
              return MaterialPageRoute( builder: (context) => NotFoundScreen() );
            }
          );


        },

      ),


    );

  }

}

