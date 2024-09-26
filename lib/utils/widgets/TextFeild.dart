import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final bool obscureText;
  final VoidCallback? onTap;  // Add onTap callback

  const LabeledTextField({
    Key? key,
    required this.label,
    this.prefixIcon,
    this.obscureText = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: MyColor.darkGreyColor,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
