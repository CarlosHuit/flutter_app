import 'package:app19022019/core/src/redux/reading_course/rc_letter_detail/rc_letter_detail_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/rc_data/rc_data_actions.dart';
import 'package:app19022019/core/src/redux/reading_course/reading_course_actions.dart';
import 'package:app19022019/core/src/models/reading_course/rc_initial_data.dart';
import 'package:app19022019/core/src/redux/navigation/navigation_actions.dart';
import 'package:app19022019/core/src/networking/reading_course_api.dart';
import 'package:app19022019/ui/reading_course/draw_letters/draw_letters_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:redux/redux.dart';
import '../app/app_state.dart';


class ReadingCourseMiddleware extends MiddlewareClass<AppState> {


  final ReadingCourseApi api;
  ReadingCourseMiddleware( this.api );


  @override
  void call(Store<AppState> store, action, NextDispatcher next) async{

    next(action);


    if (action is RCFetchInitialData) {

      try {
        final RCInitialData data = await api.fetchInitialData();
        store.dispatch(RCFetchInitialDataSuccess(data: data));
      } catch (e) {
        store.dispatch(RCFetchInitialDataFailed(error: e.toString()));
      }

    }


    if (action is RCSelectLetter) {

      store.dispatch(RCSetCurrentLetter(action.letter));
      store.dispatch(RCSetInitialDataLD(action.letter));

      // TODO -> dispacth action to start course

      next(NavigatorPushWithTransition(
        screen: DrawLettersScreen(),
        transition: PageTransitionType.rightToLeft
      ));

    }



  }
  
}