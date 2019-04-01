import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

class AudioService {
  
  static AudioCache player = AudioCache();

  static Future<dynamic> init() async {
    await player.loadAll([
      'audio/incorrect.mp3'
    ]);
  }

  static play() async {
    AudioPlayer player = AudioPlayer();
    await player.play('assets/audio/incorrect.mp3', isLocal: true);
  }

  static playAsset(AudioType audioType) {
    player.play('audio/${describeEnum(audioType)}.mp3', volume: 0.8);
  }

}

enum AudioType { incorrect, }
