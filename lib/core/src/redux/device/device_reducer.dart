import './device_state.dart';
import './device_actions.dart';

DeviceState deviceReducer(DeviceState state, dynamic action) {

  if (action is SetDeviceData) {
    return DeviceState.setState(action.context);
  }

  return state;

}