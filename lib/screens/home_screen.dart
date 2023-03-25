import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = 1500;
  late Timer timer;
  bool isRunning = false;
  bool isReset = false;
  int pomodor = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        pomodor = pomodor + 1;
        totalSeconds = 1500;
        isRunning = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPause() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onReset() {
    timer.cancel();
    setState(() {
      totalSeconds = 1500;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(format(totalSeconds),
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 90,
                      fontWeight: FontWeight.w700,
                    )),
              )),
          Flexible(
            flex: 2,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: isRunning ? onPause : onPressed,
                      iconSize: 150,
                      color: Theme.of(context).cardColor,
                      icon: isRunning
                          ? const Icon(Icons.pause_circle_outline_outlined)
                          : const Icon(Icons.play_circle_outlined),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: IconButton(
                        onPressed: onReset,
                        icon: const Icon(Icons.restore),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Pomodors',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '$pomodor',
                        style: const TextStyle(
                            fontSize: 50, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
