import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart'as http;
import './utils/utils.dart';
import './core/core.dart';
import './ui/app.dart';

void main() async {

  await setOrientationAndSetUIOverlays();
  await AudioService.init();

  final SharedPreferences preferences      = await SharedPreferences.getInstance();
  final FlutterKeyValueStore keyValueStore = FlutterKeyValueStore(preferences);
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  final Store<AppState> store = await createStore(
    client:        http.Client(),
    keyValueStore: keyValueStore,
    secureStorage: secureStorage,
  );
  
  final state = store.state;

  if (state.coursesState.courses.length == 0 && state.authState.isLoggedIn) {
    // ! fetchCourses after init App
  }


  runApp( App(store: store) );

}


