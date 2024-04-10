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
  final void Function(String value)? onChanged;
  final Color? fillColor;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;

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
    this.onChanged, 
    this.readOnly = false,
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
              readOnly: readOnly,
              maxLines: maxLines,
              minLines: minLines,
              initialValue: initialValue,
              validator: validator,
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: fillColor ?? colors.cardColor,
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
