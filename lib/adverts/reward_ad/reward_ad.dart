import 'package:custom_ad_test/callback/ad_callback.dart';
import 'package:flutter/material.dart';

import '../adverts.dart';

class RewardAd {
  static AdCallback<RewardAd>? _adCallback;

  static const int _rewardAmount = 10;

  // Load the rewarded ad (simulated delay).
  static Future<void> load({
    required int adUnitId,
    required adLoadCallback,
  }) async {
    _adCallback = adLoadCallback;

    Adverts.instance
        .loadRewardAd(adUnitId: adUnitId, adLoadCallback: adLoadCallback);
  }

  // Show the rewarded ad.
  void show(BuildContext context) {
    Adverts.instance.showRewardAd(
      context: context,
      adCallback: _adCallback,
      points: _rewardAmount,
    );
  }
}
