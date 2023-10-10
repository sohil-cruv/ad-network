import 'package:custom_ad_test/adverts/adverts.dart';
import 'package:flutter/widgets.dart';

import '../../callback/ad_callback.dart';

class InlineAd {
  static AdCallback<InlineAd>? _adCallback;
  static void load({
    required int adUnitId,
    required adLoadCallback,
  }) {
    _adCallback = adLoadCallback;
    Adverts.instance.loadInlineAd(
      adUnitId: adUnitId,
      adLoadCallback: adLoadCallback,
    );
  }

  Widget showAd({bool isCompact = false}) {
    return Adverts.instance.showInlineAd(
      adCallback: _adCallback,
      isCompact: isCompact,
    );
  }
}
