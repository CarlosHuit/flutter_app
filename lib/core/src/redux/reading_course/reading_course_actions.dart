import 'package:meta/meta.dart';

class RCFetchInitialData {}

class RCFetchInitialDataSuccess {}

class RCFetchInitialDataFailed {

  final String error;
  RCFetchInitialDataFailed({ @required this.error });

}