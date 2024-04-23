// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateAppInitWidget extends StatefulWidget {
  final Widget Function(RateMyApp) builder;
  const RateAppInitWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<RateAppInitWidget> createState() => _RateAppInitWidgetState();
}

class _RateAppInitWidgetState extends State<RateAppInitWidget> {
  static const playStoreId = "com.pro_cv.pdf";
  RateMyApp rateMyApp = RateMyApp(
    googlePlayIdentifier: playStoreId,
    minDays: 0,
    minLaunches: 2,
    remindDays: 1,
    remindLaunches: 1,
  );

  @override
  Widget build(BuildContext context) => RateMyAppBuilder(
      rateMyApp: rateMyApp,
      onInitialized: (context, rateMyApp) {
        setState(() {
          this.rateMyApp = rateMyApp;
        });
      },
      builder: (context) => widget.builder(rateMyApp));
}
