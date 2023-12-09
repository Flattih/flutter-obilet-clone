import 'package:cashback/core/common/custom_app_bar.dart';
import 'package:cashback/core/common/title_with_text_field.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/auth/mixin/sign_up_screen_mixin.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/auth/widgets/or_divider.dart';
import 'package:cashback/features/auth/widgets/social_login_row.dart';
import 'package:cashback/features/bottom_bar/bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const String routeName = "/sign_up";
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> with SignUpScreenMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, state) {
      if (state.isLoading) {
        EasyLoading.show(status: "Kayıt olunuyor...");
      }
      if (!state.isLoading) {
        EasyLoading.dismiss();
        context.toNamed(BottomNavBar.routeName);
      }
      if (state.hasError) {
        EasyLoading.showError(state.error.toString(), duration: const Duration(seconds: 3));

        ref.read(authControllerProvider.notifier).deleteAccount();

        ref.read(authControllerProvider.notifier).logout();
        context.toNamedAndRemoveUntil(SignUpScreen.routeName);
      }
    });
    return AbsorbPointer(
      absorbing: ref.watch(authControllerProvider).isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Kayıt Ol',
        ),
        body: SafeArea(
          child: Padding(
            padding: context.paddingNormalHorizontal,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithTextField(
                    hintText: "İsim Soyisim",
                    title: "İsim Soyisim",
                    controller: nameController,
                  ),
                  const Gap(32),
                  TitleWithTextField(
                    hintText: "+90 000 000 00 00",
                    title: "Telefon Numarası",
                    controller: phoneController,
                  ),
                  const Gap(32),
                  TitleWithTextField(
                    hintText: "E-Posta adresinizi Giriniz",
                    title: "E-Posta Adresi",
                    controller: emailController,
                  ),
                  const Gap(32),
                  TitleWithTextField(
                    hintText: "*********",
                    title: "Şifre",
                    controller: passwordController,
                    isObscure: passwordVisibility,
                    suffixIcon: Padding(
                      padding: context.paddingLowHorizontal,
                      child: IconButton(
                        onPressed: changePasswordVisibility,
                        icon: Icon(passwordVisibility ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  const Gap(32),
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: "Kayıt işlemine devam ederseniz, ",
                      style: context.textTheme.bodyLarge!.copyWith(color: Colors.grey),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: Privacy Policy
                              },
                            text: "Gizlilik şartlarını",
                            style: context.textTheme.bodyLarge),
                        const TextSpan(text: " ve "),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: User Agreement
                              },
                            text: "Kullanıcı Sözleşmesini",
                            style: context.textTheme.bodyLarge),
                        const TextSpan(text: " kabul etmiş olacaksınız."),
                      ],
                    ),
                  ),
                  const Gap(32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).signUpWithEmail(
                            emailController.text, passwordController.text, nameController.text, phoneController.text);
                      },
                      child: const Text("Kayıt Ol"),
                    ),
                  ),
                  const OrDivider(),
                  SocialLoginRow(
                    googleOnPressed: () {
                      ref.read(authControllerProvider.notifier).signInWithGoogle();
                    },
                    facebookOnPressed: () {},
                  ),
                  const Gap(20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
