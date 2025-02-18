import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double currentTime; // Current time remaining
  final double totalTime; // Total time for the progress bar
  final double height;
  final Color backgroundColor; // Background color of the progress bar
  final Color progressColor; // Color of the progress indicator

  const ProgressBar({
    required this.currentTime,
    required this.totalTime,
    this.height = 12.0,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LinearProgressIndicator(
        value: currentTime / totalTime, // Progress value (0.0 to 1.0)
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
