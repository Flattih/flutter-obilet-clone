import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  const SocialLoginButton({
    required this.icon,
    this.iconColor = Colors.black,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 155,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: FaIcon(icon, color: iconColor),
        ),
      ),
    );
  }
}
