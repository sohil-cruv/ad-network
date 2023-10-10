import 'dart:developer';

import 'package:advertising_id/advertising_id.dart';
import 'package:custom_ad_test/adverts/ad_configs.dart';
import 'package:custom_ad_test/adverts/inline_ad/inline_ad.dart';
import 'package:custom_ad_test/adverts/inline_ad/widgets/inline.dart';
import 'package:custom_ad_test/adverts/interstitial_ad/interstitial_ad.dart';
import 'package:custom_ad_test/adverts/interstitial_ad/widgets/interstitial.dart';
import 'package:custom_ad_test/adverts/reward_ad/reward_ad.dart';
import 'package:custom_ad_test/adverts/reward_ad/widgets/reward.dart';
import 'package:flutter/material.dart';

import 'banner_ad/banner_ad.dart';
import 'banner_ad/widgets/banner.dart';

class Adverts {
  //prevent external instantiation
  Adverts._();
  static bool _initialized = false;
  static Adverts? _instance;
  static String? _ad_id = '';

  // Getter for the instance
  static Adverts get instance {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    } else {
      return _instance!;
    }
  }

  static Future<void> initialize() async {
    if (_initialized) {
      throw Exception(
          "Adverts has already been initialized.\nAdverts has to be initialized only once.");
    }
    try {
      _ad_id = await AdvertisingId.id(true);
    } catch (e, s) {
      throw Exception('Failed to get Ad id $s');
    }
    log("Adverts has been initialized");
    _initialized = true;
    _instance = Adverts._();
    //other instantiation logic
  }

  static void updateAdConfigs(AdConfigs adConfigs) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. To update configs you must initialize it first.");
    }
    // perform update Ad config settings
  }

  Future<void> loadInterstitialAd({
    required int adUnitId,
    required adLoadCallback,
  }) async {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    // AdCallback<InterstitialAd>? adCallback;

    Future.delayed(const Duration(seconds: 5), () {
      // Simulate a successful ad load
      // send [_ad_id] to server
      print("from load of interstitial ad " + _ad_id!);
      final ad = InterstitialAd();

      adLoadCallback.onAdLoaded(ad);
    });
  }

  void showInterstitialAd({
    required adCallback,
    required BuildContext context,
  }) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    interstitialAdWidget(
      context,
      adCallback!.onAdClicked,
      onClose: () {
        if (adCallback != null) {
          adCallback!.onAdClosed();
        }
      },
    );
  }

  void loadBannerAd({
    required int adUnitId,
    required adLoadCallback,
  }) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    Future.delayed(const Duration(seconds: 5), () {
      // Simulate a successful ad load
      final ad = BannerAd();
      adLoadCallback.onAdLoaded(ad);
    });
  }

  BannerAdWidget showBannerAd({
    required adCallback,
    required BuildContext context,
    required Placement placement,
  }) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    print('Banner ad is displayed.');
    return BannerAdWidget(
      placement: placement,
      adCallback: adCallback,
    );
  }

  void loadInlineAd({
    required int adUnitId,
    required adLoadCallback,
  }) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }

    Future.delayed(Duration(seconds: 5), () {
      // Simulate a successful ad load
      final ad = InlineAd();
      adLoadCallback.onAdLoaded(ad);
    });
  }

  InlineAdWidget showInlineAd({
    required adCallback,
    required bool isCompact,
  }) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }

    return InlineAdWidget(isCompact: isCompact, adCallback: adCallback);
  }

  Future<void> loadRewardAd({
    required int adUnitId,
    required adLoadCallback,
  }) async {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    await Future.delayed(Duration(seconds: 5), () {
      // Simulate a successful ad load
      final ad = RewardAd();
      adLoadCallback.onAdLoaded(ad);
    });
  }

  void showRewardAd(
      {required BuildContext context,
      required adCallback,
      required int points}) {
    if (!_initialized) {
      throw Exception(
          "Adverts has not been initialized. Call initialize() first.");
    }
    print('Reward ad is displayed.');
    showRewardAdWidget(
        context: context, adCallback: adCallback, points: points);
  }
}
