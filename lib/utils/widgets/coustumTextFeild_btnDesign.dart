import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../resources/my_colors.dart';

Widget rectAngleDesignTextField({
  required BuildContext context,
  required TextEditingController controller,
  String? hintText,
  int? colorType,
  Color? buttonColor,
}) {
  Color fieldBgColor;
  Color tittleColor;

  if (colorType == 1) {
    fieldBgColor = MyColor.primaryColor;
    tittleColor = MyColor.whiteGreyColor;
  } else if (colorType == 2) {
    fieldBgColor = MyColor.white;
    tittleColor = MyColor.whiteDarkGreyColor;
  } else if (colorType == 3) {
    fieldBgColor = MyColor.FaceBookDarkColor;
    tittleColor = MyColor.whiteGreyColor;
  } else if (colorType == 4) {
    fieldBgColor = MyColor.GetStartedGreyColor;
    tittleColor = MyColor.darkGreyColor;
  } else {
    fieldBgColor = MyColor.primaryColor;
    tittleColor = MyColor.whiteGreyColor;
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    height: Get.height * 0.07,
    decoration: BoxDecoration(
      color: buttonColor ?? fieldBgColor,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: MyColor.GetStartedBorderGreyColor, width: 1.0),
    ),
    alignment: Alignment.center,
    child: TextField(
      controller: controller,
      enabled: false, // This makes the field non-clickable
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(
          color: tittleColor,
          fontSize: Get.width * 0.045,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: TextStyle(
        color: tittleColor,
        fontSize: Get.width * 0.045,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
