import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';

class CommonText extends StatelessWidget {
  final String text;
  final String clickableText;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final TextStyle? clickableTextStyle;

  const CommonText({
    Key? key,
    required this.text,
    required this.clickableText,
    required this.onTap,
    this.textStyle,
    this.clickableTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: textStyle ?? TextStyle(color: MyColor.darkGreyColor),
        children: [
          TextSpan(text: text),
          TextSpan(
            text: clickableText,
            style: clickableTextStyle ??
              TextStyle(fontSize: 16, color: MyColor.primaryDarkColor, fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
