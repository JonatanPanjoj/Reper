import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? label;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;

  const CustomInput({
    super.key,
    this.label,
    required this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.isPassword = false,
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
              validator: validator,
              controller: controller,
              obscureText: isPassword,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                fillColor: colors.canvasColor,
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
