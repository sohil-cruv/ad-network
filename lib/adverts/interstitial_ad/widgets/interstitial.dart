import 'package:flutter/material.dart';

void interstitialAdWidget(BuildContext context, onAdClicked,
    {required VoidCallback onClose}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
                  height: height,
                  width: width,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hands on\nInterstitial Ads ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                              onPressed: () {
                                // Navigator.pop(context);
                                onAdClicked();
                              },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith(
                                      (states) => const BorderSide(
                                          color: Colors.white))),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Visit",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                ),
                              )),
                          const SizedBox(width: 10),
                          OutlinedButton(
                              onPressed: () {
                                onClose();
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith(
                                      (states) => const BorderSide(
                                          color: Colors.white))),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
