import 'dart:async';

import 'package:flutter/services.dart';

Future<void> setOrientationAndSetUIOverlays()  async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
