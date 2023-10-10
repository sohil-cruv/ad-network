import 'package:custom_ad_test/adverts/inline_ad/inline_ad.dart';
import 'package:flutter/material.dart';

import 'callback/ad_callback.dart';

class ListPageInline extends StatefulWidget {
  const ListPageInline({super.key});

  @override
  State<ListPageInline> createState() => _ListPageInlineState();
}

class _ListPageInlineState extends State<ListPageInline> {
  late InlineAd inlineAd;
  bool isInlineAdReady = false;

  @override
  void initState() {
    super.initState();

    InlineAd.load(
      adUnitId: 123,
      adLoadCallback: AdCallback<InlineAd>(
        onAdLoaded: (ad) {
          print('loaded');
          inlineAd = ad;
          isInlineAdReady = true;
          setState(() {});
        },
        onAdClosed: () {
          print("push to new page after cloased");
        },
        onAdFailedToLoad: () {
          isInlineAdReady = false;
          setState(() {});
          print('failed to load ad');
        },
        onAdClicked: () {
          print("Ad Clicked");
        },
        onAdOpened: () {
          print("Open Triggered");
        },
        onAdImpression: () {
          print("Inline Impression Added");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (isInlineAdReady && index == 12) {
            return inlineAd.showAd(isCompact: index == 2);
          } else {
            return ListTile(
              title: Text("Index $index"),
              subtitle: Text("This is actually index ${index + 1}"),
            );
          }
        },
        itemCount: isInlineAdReady ? 19 : 17,
      ),
    );
  }
}
