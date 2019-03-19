import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';

class NavigatorPop {}
class NavigatorPushSignup {}
class NavigatorReplaceHome {}
class NavigatorReplaceSignin {}
class NavigatorPushCourseDetail {}

class NavigatorReplaceCourse {
  final String course;
  NavigatorReplaceCourse({@required this.course });
}

class NavigatorPushRCLetterDetail {}

class NavigatorPushReplaceRigthToLeft {
  final dynamic screen;
  NavigatorPushReplaceRigthToLeft(this.screen);
}

class NavigatorPushWithTransition {

  final PageTransitionType transition;
  final dynamic screen;

  NavigatorPushWithTransition({
    @required this.transition,
    @required this.screen
  });

}

class NavigatorPushReplaceWithTransition {
  
  final PageTransitionType transition;
  final dynamic screen;

  NavigatorPushReplaceWithTransition({
    @required this.transition,
    @required this.screen
  });

}
