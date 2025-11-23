// file: main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'GetX Countdown Timer Example',
    home: CountdownTimerScreen(),
  ));
}

// Step 3: Timer controller with RxInt
class TimerController extends GetxController {
  var secondsLeft = 10.obs; // starting countdown value
  Timer? _timer;

  void startCountdown() {
    _timer?.cancel(); // Cancel previous timer if any
    secondsLeft.value = 10; // reset

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft > 0) {
        secondsLeft--;
      } else {
        timer.cancel(); // stop when reaches 0
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel(); // clean up
    super.onClose();
  }
}

class CountdownTimerScreen extends StatelessWidget {
  final TimerController timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Countdown Timer with GetX')),
      body: Center(
        child: Obx(() => Text(
          'Seconds left: ${timerController.secondsLeft}',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          timerController.startCountdown();
        },
        child: Icon(Icons.timer),
        tooltip: 'Start Countdown',
      ),
    );
  }
}
