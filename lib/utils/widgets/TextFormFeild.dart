import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rate_my_portfolio/resources/my_colors.dart';

class TextFromField extends StatelessWidget {
  final TextEditingController controller;
  final dynamic prefix;
  final bool obscureText;
  final Color borderColor;
  final Color hintTextColor;
  final String? hintText;
  final Widget? suffixIcon;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const TextFromField({
    Key? key,
    required this.controller,
    this.prefix,
    this.obscureText = false,
    required this.borderColor,
    this.suffixIcon,
    this.hintText,
    required this.hintTextColor,
    this.onPressed,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          inputFormatters: keyboardType == TextInputType.phone
              ? <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(13)
          ]
              : null,
          style: TextStyle(color: MyColor.darkGreyColor),
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: MyColor.black,
            hintStyle: TextStyle(color:MyColor.HintColor),
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: suffixIcon != null ? IconButton(
              icon: suffixIcon!,
              onPressed: onPressed,
            ) : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color:borderColor),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget? _buildPrefixIcon() {
    if (prefix is IconData) {
      return Icon(prefix);
    } else if (prefix is Image) {
      return Container(
        margin: const EdgeInsets.only(right: 8),
        child: prefix,
      );
    }
    return null;
  }
}