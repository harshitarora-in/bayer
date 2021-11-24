import 'package:flutter/material.dart';

class AqiMethods {
  String getAqiStatus(int level) {
    if (level == 1) {
      return 'Good';
    } else if (level == 2) {
      return 'Fair';
    } else if (level == 3) {
      return 'Moderate';
    } else if (level == 4) {
      return 'Poor';
    } else if (level == 5) {
      return 'Very Poor';
    } else {
      return 'Error';
    }
  }

  Color getAqiStatusColor(int level) {
    if (level == 1) {
      return Colors.greenAccent;
    } else if (level == 2) {
      return Colors.green;
    } else if (level == 3) {
      return Colors.yellowAccent;
    } else if (level == 4) {
      return Colors.orange;
    } else if (level == 5) {
      return Colors.red;
    } else {
      return Colors.red;
    }
  }
}
