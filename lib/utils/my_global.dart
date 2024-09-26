// import 'dart:developer';
// import 'dart:io';
//
// import 'dart:math' as math;
//
//

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resources/my_colors.dart';

Back(){
  return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0,top: 2,bottom: 2),
        child: Icon(Icons.arrow_back_ios_new,size: 25,color: MyColor.primaryDarkColor,),
      ));
}

int timeToMin(String time) {
  try {
    List<String> timeParts = time.split(':');

    int hours = int.parse(timeParts[0]);
    int minutes = int.parse(timeParts[1]);
    // int seconds = int.parse(timeParts[2]);

    int totalMinutes = (hours * 60) + minutes;

    return totalMinutes;
  } catch (e) {
    print(e);
    return 0;
  }
}

String minToHr(int time) {
  int hours = time ~/ 60; // Calculate the hours
  int minutes = time % 60; // Calculate the remaining minutes
  String formattedTime = "";
  if (hours == 0) {
    formattedTime = '$minutes min';
  } else {
    if (minutes == 0) {
      formattedTime = '$hours hr';
    } else {
      formattedTime = '$hours hr $minutes min';
    }
  }

  return formattedTime;
}
// class MyGlobal{
//
//   ///
//   ///
//   ///
//   static String checkNullData(String? data){
//     if(data == null){
//       return '';
//     }else{
//       return data;
//     }
//   }
//
//
//   ///
//   ///
//   ///
//   static String convertServerDate(String? date){
//     log('Server-Date $date');
//     DateTime parseDate = DateTime.parse(date!);
//     DateTime dateTime = DateTime(parseDate.year, parseDate.month, parseDate.day, 00, 00, 00);
//     String formattedDate = DateFormat('dd MMM yyyy').format(dateTime);
//     return formattedDate;
//   }
//
//   ///
//   ///
//   ///
//   static Future<String> getFileSize(String filepath, int decimals) async {
//     var file = File(filepath);
//     int bytes = await file.length();
//     if (bytes <= 0) return "0 B";
//     const suffixes = ["byte", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
//     var i = (math.log(bytes) / math.log(1024)).floor();
//     return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
//   }
//
// }
