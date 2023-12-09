import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/core/lang/locale_keys.g.dart';
import 'package:cashback/features/auth/screens/sign_in_screen.dart';
import 'package:cashback/features/auth/screens/sign_up_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: context.paddingNormalHorizontal,
              child: Align(
                alignment: Alignment.topRight,
                child: Chip(
                  backgroundColor: Colors.black,
                  label: const Text(LocaleKeys.language, style: TextStyle(color: Colors.white)).tr(),
                  padding: context.paddingLow,
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            Text(
              "Yolculuğuna Hoşgeldin!",
              style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            Container(
              margin: context.paddingLowVertical,
              padding: context.paddingLow * 0.6,
              color: Colors.black,
              child: Text("Obilet ile yolculuk yap ve",
                  style: context.textTheme.headlineSmall!
                      .copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
            ),
            Text(
              "Fırsatları kaçırma",
              style: context.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            const Gap(40),
            Image.asset(
              ImageConstants.bus,
              width: 327,
              height: 212,
            ),
            const Spacer(),
            Padding(
              padding: context.paddingNormalHorizontal,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.toNamed(SignInScreen.routeName);
                  },
                  child: Text(
                    'Giriş Yap',
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Padding(
              padding: context.paddingNormalHorizontal,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                      elevation: 0),
                  onPressed: () {
                    context.toNamed(SignUpScreen.routeName);
                  },
                  child: Text(
                    'Yeni hesap oluştur',
                    style: context.textTheme.titleMedium!.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
