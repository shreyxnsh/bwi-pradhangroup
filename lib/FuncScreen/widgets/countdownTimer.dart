import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'dart:async';


class CountdownTimerWidget extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;

  CountdownTimerWidget({required this.startTime, required this.endTime});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer timer;
  bool countdownStarted = false;
  Duration? countdownDuration;
  bool isValidTime = true;

  @override
  void initState() {
    super.initState();


    log('Start Time: ${widget.startTime}');
    log('End Time: ${widget.endTime}');
    
    if (widget.startTime.isAfter(widget.endTime)) {
      log('Invalid Time');
      setState(() {
        isValidTime = false;
      });
    }

    // if null or empty 
    if (widget.startTime == null || widget.endTime == null) {
      log('Invalid Time');
      setState(() {
        isValidTime = false;
      });
    }

    DateTime currentTime = DateTime.now();

    if (currentTime.isBefore(widget.startTime)) {
      // Schedule the timer to start at the startTime
      timer = Timer(widget.startTime.difference(currentTime), startCountdown);
    } else if (currentTime.isBefore(widget.endTime)) {
      // Start the countdown immediately
      startCountdown();
    }
  }

  void startCountdown() {
    setState(() {
      countdownStarted = true;
      countdownDuration = widget.endTime.difference(DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: isValidTime && countdownStarted && countdownDuration != null
          ? SlideCountdownSeparated(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              duration: countdownDuration!,
              onDone: () {
                setState(() {
                  countdownStarted = false;
                });
              },
            )
          : Text('Countdown not started yet'),
    );
  }
}