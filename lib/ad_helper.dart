import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/2327741015';
    } else if (Platform.isIOS) {
      return '<ca-app-pub-3941005348476564~7196924317>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/2327741015';
    } else if (Platform.isIOS) {
      return '<ca-app-pub-3941005348476564~7196924317>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/2327741015';
    } else if (Platform.isIOS) {
      return '<ca-app-pub-3941005348476564~7196924317>';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
