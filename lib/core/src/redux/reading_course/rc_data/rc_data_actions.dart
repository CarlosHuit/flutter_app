import 'package:app19022019/core/src/models/reading_course/rc_initial_data.dart';
import 'package:meta/meta.dart';


class RCFetchInitialData {}

class RCFetchInitialDataSuccess {

  final RCInitialData data;
  RCFetchInitialDataSuccess({ @required  this.data });

}


class RCFetchInitialDataFailed {

  final String error;
  RCFetchInitialDataFailed({ @required this.error });

}