import 'adverts/banner_ad/banner_ad.dart';
import 'package:flutter/material.dart';

import 'callback/ad_callback.dart';

class ListPageBanner extends StatefulWidget {
  const ListPageBanner({super.key});

  @override
  State<ListPageBanner> createState() => _ListPageBannerState();
}

class _ListPageBannerState extends State<ListPageBanner> {
  late BannerAd bannerAd;

  bool isBannerAdReady = false;
  @override
  void initState() {
    super.initState();

    BannerAd.load(
      adUnitId: 123,
      adLoadCallback: AdCallback<BannerAd>(
          onAdLoaded: (ad) {
            print('loaded banner');
            bannerAd = ad;
            isBannerAdReady = true;
            setState(() {});
          },
          onAdClosed: () {},
          onAdFailedToLoad: () {
            isBannerAdReady = false;
            setState(() {});
            print('failed to load ad');
          },
          onAdClicked: () {
            print("Ad Clicked");
          },
          onAdOpened: () {
            print("Triggered Ad Opened");
          },
          onAdImpression: () {
            print("Banner Impression Recorded");
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Index $index"),
                subtitle: Text("This is actually index ${index + 1}"),
              );
            },
            itemCount: 17,
          ),
          isBannerAdReady ? bannerAd.showAd(context: context) : Container()
        ],
      ),
    );
  }
}
