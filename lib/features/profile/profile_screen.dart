import 'package:cashback/core/common/custom_app_bar.dart';
import 'package:cashback/core/constants/constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        hasLeading: false,
        title: "Hesabım",
        backgroundColor: context.primaryColor,
        titleColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: context.paddingLowVertical * 2,
                child: Consumer(
                  builder: (context, ref, child) {
                    final user = ref.watch(userProvider);
                    return Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "Merhaba  "),
                          TextSpan(text: user?.username ?? "", style: const TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                    );
                  },
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: context.paddingMediumHorizontal.copyWith(top: 0, bottom: 0),
                    itemCount: profileItems.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(
                        color: Colors.grey,
                        height: 2,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final title = profileItems[index]["title"] as String;
                      final icon = profileItems[index]["icon"] as Icon;
                      return ListTile(
                        dense: true,
                        title: Text(title, style: context.textTheme.bodyLarge),
                        leading: icon,
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                      );
                    },
                  );
                },
              ),
              Consumer(
                builder: (context, ref, child) => GestureDetector(
                  onTap: () {
                    ref.read(authControllerProvider.notifier).logout();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 14),
                    child: ListTile(
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                      ),
                      dense: true,
                      title: Text(
                        "Çıkış Yap",
                        style: context.textTheme.bodyLarge,
                      ),
                      leading: const Icon(
                        Icons.logout,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
