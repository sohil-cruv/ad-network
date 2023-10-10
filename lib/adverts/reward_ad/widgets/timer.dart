import 'dart:async';

import 'package:custom_ad_test/callback/ad_callback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SkipAdTimer extends StatefulWidget {
  const SkipAdTimer(
      {super.key, required this.adCallback, required this.points});
  final AdCallback adCallback;
  final int points;
  @override
  SkipAdTimerState createState() => SkipAdTimerState();
}

class SkipAdTimerState extends State<SkipAdTimer> {
  late Timer _timer;
  int _start = 10;

  void startTimer() {
    const Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
      child: _start != 0
          ? CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey,
              child: Text(
                _start.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          : GestureDetector(
              onTap: () {
                widget.adCallback.onRewarded!(widget.points);
                widget.adCallback.onAdClosed();
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                      child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
