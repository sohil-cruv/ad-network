import 'package:custom_ad_test/adverts/adverts.dart';
import 'package:custom_ad_test/adverts/banner_ad/widgets/banner.dart';
import 'package:flutter/widgets.dart';

import '../../callback/ad_callback.dart';

class BannerAd {
  static AdCallback<BannerAd>? _adCallback;
  static void load({
    required int adUnitId,
    required adLoadCallback,
  }) {
    _adCallback = adLoadCallback;
    Adverts.instance
        .loadBannerAd(adUnitId: adUnitId, adLoadCallback: adLoadCallback);
  }

  Widget showAd({
    required BuildContext context,
    Placement placement = Placement.bottom,
  }) {
    _adCallback!.onAdImpression();

    return Adverts.instance.showBannerAd(
      context: context,
      adCallback: _adCallback,
      placement: placement,
    );
  }
}
