import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class DeviceState {

  final Size size;
  final double width;
  final double height;
  final TargetPlatform platform;

  DeviceState({
    @required this.size,
    @required this.width,
    @required this.height,
    @required this.platform
  });

  factory DeviceState.initialState() {


    return DeviceState(
      size:     null,
      width:    null,
      height:   null,
      platform: null,
    );
  }

  factory DeviceState.setState(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final platform = Theme.of(context).platform;

    return DeviceState(
      size:     size,
      width:    size.width,
      height:   size.height,
      platform: platform
    );
  }

}