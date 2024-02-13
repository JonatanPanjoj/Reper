import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String? hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;

  const CustomInput({
    super.key,
    this.label,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
    this.fillColor,
    this.initialValue,
    this.maxLines = 1,
    this.minLines,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colors = Theme.of(context);
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Text(label!, style: textStyle.titleSmall)
              : const SizedBox(),
          SizedBox(height: label != null ? 8 : 0),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: TextFormField(
              maxLines: maxLines,
              minLines: minLines,
              initialValue: initialValue,
              validator: validator,
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: fillColor ?? colors.canvasColor,
                suffixIcon: suffixIcon,
                filled: true,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
