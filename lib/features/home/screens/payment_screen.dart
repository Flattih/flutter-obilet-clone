import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/core/extension/string_extension.dart';
import 'package:cashback/core/utils/utils.dart';
import 'package:cashback/features/home/mixin/payment_screen_mixin.dart';
import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:cashback/features/home/notifiers/selected_seats_controller.dart';
import 'package:cashback/features/my_travels/my_travels_screen.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  static const routeName = "/payment-screen";
  const PaymentScreen({super.key, required this.expedition});
  final Expedition expedition;

  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> with PaymentScreenMixin {
  @override
  Widget build(BuildContext context) {
    final selectedSeats = ref.watch(selectedSeatsControllerProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const FaIcon(FontAwesomeIcons.message)),
      appBar: AppBar(
        backgroundColor: context.primaryColor,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text("obilet",
            style: context.textTheme.headlineMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: context.paddingNormalHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.expedition.agency!.logo!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      Text(DateFormat('HH:mm').format(widget.expedition.departureTime!),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                      const Text("25 Kasım Cmt", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.expedition.departurePlace}  >  ${widget.expedition.destinationPlace}",
                          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.expedition.price} TL",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Bilet İşlemleri: ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: "Biletiniz açığa alınamaz, değiştirilemez veya iade edilemez.",
                              style: TextStyle(height: 1.52, color: Colors.black54, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ColoredBox(
              color: Colors.white,
              child: Column(
                children: [
                  const Gap(10),
                  const Divider(
                    thickness: 1.5,
                  ),
                  const Gap(10),
                  Padding(
                    padding: context.paddingMediumHorizontal,
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.grey),
                        const Gap(10),
                        Text("${selectedSeats.length} Yolcu"),
                        const Spacer(),
                        Text(
                          "Toplam Fiyat : ",
                          style: context.textTheme.labelLarge,
                        ),
                        Text("${selectedSeats.length * int.parse(widget.expedition.price!)} TL",
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                  const Gap(20),
                  const Divider(
                    thickness: 1.5,
                    height: 0,
                  ),
                ],
              ),
            ),
            const Gap(25),
            PaymentCardWidget(
              firstTitle: 'CEP TELEFONU',
              secondTitle: 'E-MAİL',
              forPhoneTextField: true,
              firstHintText: '5xx xxx xx xx',
              secondHintText: 'fatihyilmaz@gmail.com',
              firstController: phoneController,
              secondController: emailController,
              informationTitle: 'İLETİŞİM BİLGİLERİ',
            ),
            const Gap(25),
            PaymentCardWidget(
              firstTitle: 'AD SOYAD',
              secondTitle: 'T.C. KİMLİK NO',
              firstHintText: 'Fatih YILMAZ',
              secondHintText: '12345678910',
              firstController: nameController,
              secondController: tcController,
              informationTitle: 'YOLCU BİLGİLERİ',
            ),
            const Gap(25),
            Center(
              child: SizedBox(
                width: context.width - 110,
                height: 40,
                child: OutlinedButton(
                  onPressed: _makePayment,
                  child: Text(
                    "Ödeme Yap: ${selectedSeats.length * int.parse(widget.expedition.price!)} TL",
                    style: context.textTheme.labelLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Gap(40),
          ],
        ),
      ),
    );
  }

  void _makePayment() {
    if (phoneController.text.isNotEmpty &&
        emailController.text.isValidEmail() &&
        nameController.text.isNotEmpty &&
        tcController.text.isNotEmpty) {
      _reserveSeat();
    } else {
      showSnackBar(backgroundColor: const Color(0xFF0FA67C), context, "Lütfen tüm alanları doldurunuz");
    }
  }

  void _reserveSeat() {
    ref.read(expeditionControllerProvider.notifier).reserveSeat(widget.expedition.id!).then((isSuccess) {
      showAdaptiveDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          ref.invalidate(selectedSeatsControllerProvider);
          return AlertDialog(
            titleTextStyle: TextStyle(
              color: isSuccess ? Colors.green : context.secondaryColor,
            ),
            contentTextStyle: TextStyle(
              color: isSuccess ? Colors.green : context.secondaryColor,
            ),
            title: isSuccess ? const Text("Harika!") : const Text("Hata"),
            content: isSuccess
                ? const Text("Koltuklarınız başarıyla rezerve edildi")
                : const Text("Koltuklarınız rezerve edilemedi"),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(expeditionControllerProvider.notifier).updateExpeditionById(widget.expedition.id!);
                  context.pop();
                  context.pop();
                },
                child: Text("Tamam", style: TextStyle(color: isSuccess ? Colors.green : context.secondaryColor)),
              )
            ],
          );
        },
      );
    });
  }
}

class PaymentCardWidget extends StatelessWidget {
  final String firstTitle, secondTitle, firstHintText, secondHintText, informationTitle;
  final TextEditingController firstController, secondController;
  final bool forPhoneTextField;
  const PaymentCardWidget({
    required this.firstTitle,
    required this.secondTitle,
    required this.firstHintText,
    required this.secondHintText,
    required this.firstController,
    required this.secondController,
    required this.informationTitle,
    this.forPhoneTextField = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          width: double.infinity,
          alignment: Alignment.topLeft,
          padding: context.paddingNormal.copyWith(left: 18, top: 20, bottom: 10),
          margin: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Text(
                firstTitle,
                style: context.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  forPhoneTextField
                      ? Container(
                          padding: context.paddingLow.copyWith(right: 25),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "TR+90",
                            style: TextStyle(letterSpacing: 1.5),
                          ),
                        )
                      : const SizedBox.shrink(),
                  forPhoneTextField ? const Gap(25) : const SizedBox.shrink(),
                  Expanded(
                    child: TextFormField(
                      controller: firstController,
                      maxLength: forPhoneTextField ? 10 : null,
                      style: context.textTheme.labelLarge!.copyWith(color: Colors.black),
                      decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.check, color: Colors.green),
                          counterText: "",
                          border: InputBorder.none,
                          hintText: firstHintText,
                          hintStyle: context.textTheme.labelLarge!.copyWith(color: Colors.grey, fontSize: 20)),
                    ),
                  ),
                ],
              ),
              const Divider(
                thickness: 1.5,
              ),
              const Gap(8),
              Text(
                secondTitle,
                style: context.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap(5),
              TextFormField(
                controller: secondController,
                style: context.textTheme.labelLarge!.copyWith(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.check, color: Colors.green),
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                    hintText: secondHintText),
              )
            ],
          ),
        ),
        InformationHeader(title: informationTitle),
      ],
    );
  }
}
