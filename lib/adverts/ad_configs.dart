class AdConfigs {
  /// Maximum content rating that will be shown.
  final String? maxAdContentRating;

  // /// Whether to tag as child directed.
  // final int? tagForChildDirectedTreatment;

  /// Whether to tag as under age of consent.
  final int? tagForUnderAgeOfConsent;

  /// List of test device ids to set.
  final List<String>? testDeviceIds;

  AdConfigs(
      {this.maxAdContentRating,
      // this.tagForChildDirectedTreatment,
      this.tagForUnderAgeOfConsent,
      this.testDeviceIds});
}
