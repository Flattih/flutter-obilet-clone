import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/my_travels/widgets/title_description.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class TravelTicket extends StatelessWidget {
  final String departurePlace;
  final String destinationPlace;
  final List<BusSeatNumber> seatNoList;
  final String price;
  final DateTime departureTime;
  final String id;
  const TravelTicket({
    super.key,
    required this.departurePlace,
    required this.destinationPlace,
    required this.seatNoList,
    required this.price,
    required this.departureTime,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      margin: context.paddingLowVertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12).copyWith(bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(ImageConstants.plane, width: 50, height: 50),
                Text(
                  departureTime.isAfter(DateTime.now()) ? "Beklemede" : "Sefer Gerçekleşti",
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          const Gap(10),
          const Text(
            "İzmir (İzmir Otogarı) - İstanbul (Esenler Otogarı)",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Gap(5),
          Text(DateFormat("dd MMMM y EEEE - HH:mm").format(departureTime)),
          const Gap(20),
          Row(
            children: List.generate(
                150 ~/ 2,
                (index) => Expanded(
                      child: Container(
                        color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                        height: 2,
                      ),
                    )),
          ),
          const Gap(25),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Consumer(
                builder: (context, ref, child) {
                  return Text(
                    ref.read(userProvider)!.username,
                    style: const TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
          ),
          const Gap(17),
          FittedBox(
            child: Row(
              children: [
                TitleDescription(
                  title: "PNR",
                  description: id.substring(0, 7).toUpperCase(),
                ),
                TitleDescription(
                  title: "KOLTUK NO",
                  description: seatNoList.map((e) => e.number).join(","),
                ),
                TitleDescription(
                  title: "FİYAT",
                  description: "${seatNoList.length * int.parse(price)} TL",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Biletinizde işlem gerçekleştirebilmek için Canlı Destek'le iletişime geçiniz.",
              style: TextStyle(color: context.primaryColor),
            ),
          ),
          const Divider(
            thickness: 1.5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 35, bottom: 20, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Toplam Tutar:",
                  style: TextStyle(fontSize: 16, color: Color(0xFF7C7C7C), fontWeight: FontWeight.bold),
                ),
                Text("${seatNoList.length * int.parse(price)} TL",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}
