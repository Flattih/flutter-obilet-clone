import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height = 75,
    required this.title,
    this.backgroundColor,
    this.titleColor,
    this.hasLeading = true,
  });
  final double height;
  final String title;
  final Color? backgroundColor;
  final Color? titleColor;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: hasLeading,
      title: Text(title, style: TextStyle(color: titleColor)),
      leading: hasLeading
          ? Padding(
              padding: context.paddingLowHorizontal * 1.6,
              child: const BackButton(),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
