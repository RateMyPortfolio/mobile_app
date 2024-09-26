import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplaySnackbar {
  void errorSnackBar({required String title, required String msg}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      messageText: Text(
        msg,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      backgroundGradient: LinearGradient(colors: [
        Colors.red.shade700,
        Colors.red.withOpacity(0.7),
      ], end: Alignment.centerRight, begin: Alignment.centerLeft),
      backgroundColor: Colors.white70,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      barBlur: 10.0,
      duration: Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void successSnackBar({required String title, required String msg}) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      messageText: Text(
        msg,
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      margin: EdgeInsets.only(top: 10, right: 10, left: 10),
      backgroundGradient: LinearGradient(colors: [
        Color.fromARGB(255, 58, 155, 12),
        Color.fromARGB(100, 86, 223, 22),
      ], end: Alignment.centerRight, begin: Alignment.centerLeft),
      backgroundColor: Colors.white70,
      snackPosition: SnackPosition.TOP,
      borderRadius: 20,
      barBlur: 10.0,
      duration: Duration(seconds: 2),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
