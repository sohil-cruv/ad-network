import 'package:custom_ad_test/callback/ad_callback.dart';
import 'package:flutter/material.dart';

enum Placement { bottom, top }

class BannerAdWidget extends StatelessWidget {
  const BannerAdWidget(
      {super.key, required this.placement, required this.adCallback});
  final Placement placement;
  final AdCallback adCallback;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: placement == Placement.top
          ? Alignment.topCenter
          : Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {
          adCallback.onAdClicked();
          adCallback.onAdOpened();
        },
        child: Container(
          height: 50,
          color: Colors.yellow,
          child: Center(
            child: Text(
              "Hello from Banner Ad.",
            ),
          ),
        ),
      ),
    );
  }
}
