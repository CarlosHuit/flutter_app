import 'package:app19022019/ui/reading_course/find_letters/find_letters_screen.dart';
import 'package:app19022019/ui/reading_course/game/game_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:app19022019/core/core.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import './home/home_screen.dart';
import './auth/login/login_screen.dart';
import './auth/signup/signup_screen.dart';
import '../ui/not_found/not_found_screen.dart';
import '../ui/course_detail/course_detail_screen.dart';
import '../ui/reading_course/reading_course_screen.dart';
import '../ui/reading_course/letter_detail/letter_detail_screen.dart';


final Map<String, WidgetBuilder> routes = {
  '/home':                             (context) => HomeScreen(),
  '/signin':                           (context) => LoginScreen(),
  '/signup':                           (context) => SignupScreen(),
  '/course-detail':                    (context) => CourseDetailScree(), 
  '/courses/lectura':                  (context) => ReadingCourseScreen(), 
  '/courses/lectura/detalle-letra':    (context) => LetterDetailScreen(), 
  '/courses/lectura/juego':            (context) => GameScreen(), 
  '/courses/lectura/encontrar-letras': (context) => FindLettersScreen(), 
};



final String youtubeApi = 'AIzaSyAdPTF-t9WCnHOUB6zWxZK4RrBemOvgrMQ';

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

        distinct:  true,
        converter: (store) => AppViewModel.fromStore(store),
        builder:   (_, viewModel) => MaterialApp(

          title:        'WeLearn',
          theme:        ThemeData(

            hintColor:  Colors.white,
            errorColor: Colors.orange,
            fontFamily: 'Roboto'

          ),
          home:         viewModel.isLoggedIn ? HomeScreen() : LoginScreen(),
          routes:       routes,
          navigatorKey: NavigationKey.key,
          debugShowCheckedModeBanner: false,
          onUnknownRoute: (settings) => MaterialPageRoute(
            builder: (context) => NotFoundScreen()
          )

        )

      ),


    );

  }

}

