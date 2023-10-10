import 'package:custom_ad_test/adverts/ad_configs.dart';
import 'package:custom_ad_test/adverts/adverts.dart';
import 'package:custom_ad_test/adverts/reward_ad/reward_ad.dart';
import 'package:flutter/material.dart';

import 'adverts/interstitial_ad/interstitial_ad.dart';
import 'callback/ad_callback.dart';
import 'list_page_banner.dart';
import 'list_page_inline.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Adverts.initialize();
  Adverts.updateAdConfigs(AdConfigs(
    testDeviceIds: [],
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late RewardAd rewardAd;
  late InterstitialAd interstitialAd;
  bool interReady = false;
  bool rewardAdReady = false;
  @override
  void initState() {
    super.initState();

    RewardAd.load(
        adUnitId: 343,
        adLoadCallback: AdCallback<RewardAd>(
            onAdLoaded: (ad) {
              print('Reward Ad loaded.');
              rewardAd = ad;
              rewardAdReady = true;
            },
            onAdClosed: () {
              print("push to new page after closed");
            },
            onAdFailedToLoad: () {
              rewardAdReady = false;
              print('failed to load ad');
            },
            onAdClicked: () {
              print("Reward Ad Clicked");
            },
            onAdOpened: () {},
            onAdImpression: () {
              print("Impression notice");
            },
            onRewarded: (int points) {
              print("you are rewarded with $points points");
            }));

    InterstitialAd.load(
      adUnitId: 123,
      adLoadCallback: AdCallback<InterstitialAd>(
          onAdLoaded: (ad) {
            print('Interstitial Ad loaded.');
            interstitialAd = ad;
            interReady = true;
          },
          onAdClosed: () {
            print("push to new page after closed");
          },
          onAdFailedToLoad: () {
            interReady = false;
            print('failed to load ad');
          },
          onAdClicked: () {
            print("Interstitial Ad Clicked");
          },
          onAdOpened: () {},
          onAdImpression: () {
            print("Impression notice");
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (rewardAdReady) {
                  rewardAd.show(context);
                  return;
                } else {
                  //Can be used to route to new page also
                  print("Loading");
                }
              },
              child: const Text("Reward Ad"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (interReady) {
                  interstitialAd.show(context);
                } else {
                  print("Push to new page");
                }
              },
              child: const Text("Interstitial Ad"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListPageInline(),
                    ));
              },
              child: const Text("Inline Ad"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListPageBanner(),
                    ));
              },
              child: const Text("Banner Ad"),
            )
          ],
        ),
      ),
    );
  }
}
