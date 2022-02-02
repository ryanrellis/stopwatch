import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = false;
  int milliseconds = 0;
  Timer? timer;

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    void _startTimer() {
      timer = Timer.periodic(Duration(milliseconds: 100), _onTick);
      setState(() {
        isTicking = true;
      });
    }

    void _stopTimer() {
      timer!.cancel();
      setState(() {
        isTicking = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Stopwatch"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_secondsText(milliseconds)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? null : _startTimer,
                child: Text("Start"),
              ),
              SizedBox(
                width: 20.0,
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: isTicking ? _stopTimer : null,
                child: Text("Stop"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
