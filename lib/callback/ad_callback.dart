import 'package:flutter/material.dart';

class AdCallback<T> {
  final Function(T) onAdLoaded;
  final VoidCallback onAdClosed;
  final VoidCallback onAdFailedToLoad;
  final VoidCallback onAdClicked;
  final VoidCallback onAdOpened;
  final VoidCallback onAdImpression;
  final Function(int)? onRewarded;

  AdCallback({
    required this.onAdLoaded,
    required this.onAdFailedToLoad,
    required this.onAdClosed,
    required this.onAdClicked,
    required this.onAdOpened,
    required this.onAdImpression,
    this.onRewarded,
  });
}
