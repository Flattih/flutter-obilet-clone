import 'package:cashback/core/common/custom_app_bar.dart';
import 'package:cashback/core/common/title_with_text_field.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/auth/mixin/sign_in_screen_mixin.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/auth/widgets/or_divider.dart';
import 'package:cashback/features/auth/widgets/social_login_row.dart';
import 'package:cashback/features/bottom_bar/bottom_bar.dart';
import 'package:cashback/features/welcome/welcome_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeName = '/sign-in';
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> with SignInScreenMixin {
  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (_, state) {
      if (state.isLoading) {
        EasyLoading.show(status: "Giriş yapılıyor...");
      }
      if (!state.isLoading) {
        EasyLoading.dismiss();
        context.toNamed(BottomNavBar.routeName);
      }
      if (state.hasError) {
        state.error is DioException
            ? EasyLoading.showError((state.error as DioException).message ?? "Something went wrong")
            : EasyLoading.showError("Kullanıcı adı veya şifre hatalı.");
        ref.read(authControllerProvider.notifier).logout();
        context.toNamedAndRemoveUntil(WelcomeScreen.routeName);
      }
    });
    return AbsorbPointer(
      absorbing: ref.watch(authControllerProvider).isLoading,
      child: Scaffold(
        appBar: const CustomAppBar(title: "Giriş Yap"),
        body: Padding(
          padding: context.paddingNormalHorizontal,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWithTextField(
                    title: "E-Posta Adresi", hintText: "E-Posta adresinizi giriniz.", controller: emailController),
                const Gap(32),
                TitleWithTextField(
                  title: "Şifre",
                  hintText: "Şifrenizi giriniz.",
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
                const Gap(50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => ref.read(authControllerProvider.notifier).signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        ),
                    child: const Text(
                      "Giriş Yap",
                    ),
                  ),
                ),
                const Gap(15),
                const OrDivider(),
                SocialLoginRow(
                  googleOnPressed: () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
                  facebookOnPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
