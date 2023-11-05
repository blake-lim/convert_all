import 'package:flutter/services.dart';

class OrientationLocker {
  static void lockPortrait() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static void unlock() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }
}
