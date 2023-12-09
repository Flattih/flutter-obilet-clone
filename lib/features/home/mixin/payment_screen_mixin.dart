import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/home/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin PaymentScreenMixin on ConsumerState<PaymentScreen> {
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final TextEditingController nameController;
  late final TextEditingController tcController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: ref.read(userProvider)!.phone);
    emailController = TextEditingController(text: ref.read(userProvider)!.email);
    nameController = TextEditingController(text: ref.read(userProvider)!.username);
    tcController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    emailController.dispose();
    nameController.dispose();
    tcController.dispose();
  }
}
