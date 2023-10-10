import 'package:custom_ad_test/callback/ad_callback.dart';
import 'package:custom_ad_test/focus_detector.dart';
import 'package:flutter/material.dart';

class InlineAdWidget extends StatelessWidget {
  const InlineAdWidget(
      {super.key, required this.isCompact, required this.adCallback});
  final bool isCompact;
  final AdCallback adCallback;
  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusGained: () {
        print('Inline ad is displayed.');
        adCallback.onAdImpression();
      },
      child: GestureDetector(
        onTap: () {
          adCallback.onAdClicked();
          adCallback.onAdOpened();
        },
        child: SizedBox(
          height: isCompact ? 250 : 280,
          child: const Card(
            color: Colors.yellow,
            child: Center(
              child: Text(
                "Hello from Inline Ad.",
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
