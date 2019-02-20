import 'package:flutter/services.dart';

Future<void> setOrientation()  async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
