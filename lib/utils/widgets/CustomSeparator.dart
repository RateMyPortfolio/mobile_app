import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';

class CustomSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: MyColor.darkGreyColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "or",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: MyColor.darkGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}