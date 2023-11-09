import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AdManager {
  late String admobBannerId;
  late BannerAd _bannerAd;

  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if (kReleaseMode) {
        return 'ca-app-pub-4006467454848690/9026395085'; // Release unit id
      } else {
        return 'ca-app-pub-3940256099942544/6300978111'; // Test unit id
      }
    } else if (Platform.isIOS) {
      if (kReleaseMode) {
        return 'ca-app-pub-4006467454848690/1669228365'; // Release unit id
      } else {
        return 'ca-app-pub-3940256099942544/2934735716'; // Test unit id
      }
    } else {
      throw UnsupportedError('Unsupported platform error');
    }
  }

  void initialize() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: bannerAdUnitId,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // 광고 로드 시 처리
        },
        onAdFailedToLoad: (ad, error) {
          print(error.message);
        },
      ),
      request: const AdRequest(),
    );
    _bannerAd.load();
  }

  BannerAd get bannerAd => _bannerAd;
}
