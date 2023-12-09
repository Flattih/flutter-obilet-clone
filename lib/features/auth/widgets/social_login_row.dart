import 'package:cashback/features/auth/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SocialLoginRow extends StatelessWidget {
  final VoidCallback googleOnPressed;
  final VoidCallback facebookOnPressed;
  const SocialLoginRow({
    super.key,
    required this.googleOnPressed,
    required this.facebookOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          InkWell(
            onTap: googleOnPressed,
            child: const SocialLoginButton(
              icon: FontAwesomeIcons.google,
            ),
          ),
          const Gap(20),
          InkWell(
            onTap: facebookOnPressed,
            child: const SocialLoginButton(
              icon: FontAwesomeIcons.apple,
            ),
          ),
        ],
      ),
    );
  }
}
