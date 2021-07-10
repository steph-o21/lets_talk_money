import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/2478950108';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3941005348476564/4570760977';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/5688880455';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3941005348476564/6372650008';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3941005348476564/2327741015';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3941005348476564/5059568337';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
}
