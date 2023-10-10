import 'package:flutter/material.dart';

import '../../callback/ad_callback.dart';
import '../adverts.dart';

class InterstitialAd {
  static AdCallback<InterstitialAd>? _adCallback;
  static void load({
    required int adUnitId,
    required adLoadCallback,
  }) {
    _adCallback = adLoadCallback;
    Adverts.instance
        .loadInterstitialAd(adUnitId: adUnitId, adLoadCallback: adLoadCallback);
  }

  void show(BuildContext context) {
    _adCallback!.onAdImpression();
    Adverts.instance
        .showInterstitialAd(context: context, adCallback: _adCallback);
  }
}
