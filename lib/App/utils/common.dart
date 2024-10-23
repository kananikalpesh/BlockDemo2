import 'package:flutter/material.dart';

void removeFocus() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String formatRuntime(String? runtime) {
  if (runtime == null || runtime.isEmpty) return "N/A";

  // Extract the numeric part of the runtime (e.g., "130 min" -> 130)
  int minutes = int.tryParse(runtime.replaceAll(RegExp(r'\D'), '')) ?? 0;

  int hours = minutes ~/ 60;
  int remainingMinutes = minutes % 60;

  return "${hours}h ${remainingMinutes} m";
}

bool isNumeric(String str) {
  return RegExp(r'^\d+$').hasMatch(str);
}
