import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TitleWithTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final bool? isObscure;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const TitleWithTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    this.isObscure,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(15),
        TextField(
          style: const TextStyle(color: Colors.black54),
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          obscureText: isObscure ?? false,
          decoration: InputDecoration(
              hintText: hintText, suffixIcon: suffixIcon, hintStyle: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }
}
