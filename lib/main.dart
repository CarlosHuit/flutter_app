import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import './ui/app.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import './utils/utils.dart';
import './core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';

void main() async {

  await setOrientation();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final FlutterKeyValueStore keyValueStore = FlutterKeyValueStore(prefs);

  final FlutterSecureStorage secureStorage =FlutterSecureStorage();
  final String token = await secureStorage.read( key: 'token');

  final Store<AppState> store = createStore(
    client:        Client(),
    keyValueStore: keyValueStore,
    secureStorage: secureStorage
  );

  runApp( App(
    store: store,
    hasToken: token != null ? true : false
  ) );
}
