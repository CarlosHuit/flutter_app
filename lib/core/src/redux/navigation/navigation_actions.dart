import 'package:meta/meta.dart';

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