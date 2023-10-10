import 'package:custom_ad_test/adverts/reward_ad/widgets/timer.dart';
import 'package:custom_ad_test/callback/ad_callback.dart';
import 'package:flutter/material.dart';

void showRewardAdWidget(
    {required BuildContext context,
    required AdCallback adCallback,
    required int points}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  final topPad = MediaQuery.of(context).padding.top;
  final bottomPad = MediaQuery.of(context).viewInsets.bottom;
  final viewHeight = height - topPad - bottomPad;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext ctx) {
      adCallback.onAdImpression();

      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: viewHeight * 0.91,
                  color: Colors.yellow,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.white,
                    height: viewHeight * 0.09,
                    child: Row(
                      children: [
                        const Divider(height: 0),
                        const SizedBox(width: 10),
                        Container(
                          height: 55,
                          width: 55,
                          color: Colors.grey.shade100,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ad Title",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Subtitle",
                              // style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              adCallback.onAdClicked();
                              adCallback.onAdOpened();
                            },
                            child: const Text("Visit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SkipAdTimer(
                    adCallback: adCallback,
                    points: points,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
