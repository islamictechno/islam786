import 'dart:io';

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4303834308308049/6318054859';
    } else {
      throw new UnsupportedError('Unsupported platform');
    }
  }
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4303834308308049/6405437347";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }


}
