import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/selected_seats_controller.dart';
import 'package:cashback/features/home/screens/payment_screen.dart';
import 'package:cashback/features/home/widgets/bus_seat.dart';
import 'package:cashback/features/home/widgets/bus_seat_type.dart';
import 'package:cashback/features/home/widgets/bus_wheels.dart';
import 'package:cashback/features/home/widgets/selected_seat.dart';
import 'package:cashback/models/home/res/get_expedition_by_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ExpeditionCard extends ConsumerStatefulWidget {
  final Expedition expedition;
  const ExpeditionCard({
    super.key,
    required this.expedition,
  });

  @override
  ConsumerState<ExpeditionCard> createState() => _ExpeditionCardState();
}

class _ExpeditionCardState extends ConsumerState<ExpeditionCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('HH:mm').format(widget.expedition.departureTime!);
    final List<BusSeatNumber> availableSeats =
        widget.expedition.busSeatNumbers!.where((element) => element.isAvailable == true).toList();
    print("available: " + availableSeats.length.toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                        imageUrl: widget.expedition.agency!.logo!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain),
                  ),
                  Text(formattedTime, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text("${widget.expedition.price} TL",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 20, color: Colors.grey),
                        const Gap(5),
                        Text(
                          "${widget.expedition.estimatedArrival}*",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      availableSeats.length - 2 == 2
                          ? "Son 2 Koltuk"
                          : availableSeats.length - 2 == 1
                              ? "Son 1 Koltuk"
                              : "${availableSeats.length - 2} Koltuk",
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 10, left: 15, bottom: 3),
                      child: Text(
                        "${widget.expedition.departurePlace}  >  ${widget.expedition.destinationPlace}",
                        style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5).copyWith(bottom: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 9),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration:
                          BoxDecoration(color: const Color(0xFFDFFADC), borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.discount_outlined,
                            size: 15,
                            color: Colors.grey,
                          ),
                          Gap(5),
                          Text("60₺ İndirim Kodu", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black)),
                          child: Icon(
                            isExpanded ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
                            size: 16,
                          ),
                        ),
                        Text(isExpanded ? "Kapat" : "İncele", style: const TextStyle(fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
              isExpanded
                  ? Padding(
                      padding: context.paddingNormal / 1.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BusSeatTypesRow(),
                          const Gap(20),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all()),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: context.width,
                                  child: GridView.builder(
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 26,
                                    itemBuilder: (BuildContext context, int index) {
                                      int oddStarterIndex = 2;
                                      int evenStarterIndex = 3;
                                      int seatNumber = 0;
                                      if (index % 2 == 0) {
                                        seatNumber = evenStarterIndex + (index ~/ 2) * 3;
                                      } else {
                                        seatNumber = oddStarterIndex + (index ~/ 2) * 3;
                                      }
                                      final gender = widget.expedition.busSeatNumbers![seatNumber].gender;
                                      return BusSeat(
                                        expiditionId: widget.expedition.id!,
                                        seatNumber: seatNumber,
                                        gender: gender,
                                      );
                                    },
                                  ),
                                ),
                                const Gap(30),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 40,
                                    itemBuilder: (BuildContext context, int index) {
                                      final gender = widget.expedition.busSeatNumbers![index].gender;
                                      return index % 3 == 1
                                          ? BusSeat(
                                              height: 30,
                                              width: 30,
                                              expiditionId: widget.expedition.id!,
                                              seatNumber: index,
                                              gender: gender,
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const BusWheels(),
                          Center(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedSeats = ref.watch(selectedSeatsControllerProvider);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    selectedSeats.isEmpty
                                        ? const Text("Lütfen yukarıdan koltuk seçin")
                                        : SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text("Seçtiğiniz koltuklar :"),
                                                const Gap(5),
                                                Row(
                                                  children: selectedSeats
                                                      .map(
                                                        (e) => SelectedSeat(seatNumber: "${e.seatNumber}"),
                                                      )
                                                      .toList(),
                                                )
                                              ],
                                            ),
                                          ),
                                    const Gap(10),
                                    selectedSeats.isNotEmpty
                                        ? Text(
                                            "Toplam Fiyat :  ${int.parse(widget.expedition.price!) * selectedSeats.length} TL",
                                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          )
                                        : const SizedBox.shrink(),
                                    const Gap(30),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: ref.watch(selectedSeatsControllerProvider).isNotEmpty
                                            ? null
                                            : const Color(0xFFE0E0E0),
                                        fixedSize: Size(context.width / 2, 47),
                                      ),
                                      onPressed: () {
                                        context.toNamed(PaymentScreen.routeName, arguments: widget.expedition);
                                        /*  ref
                                            .read(expeditionControllerProvider.notifier)
                                            .reserveSeat(widget.expedition.id!)
                                            .then((isSuccess) {
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
                                                      context.pop();
                                                      ref
                                                          .read(expeditionControllerProvider.notifier)
                                                          .updateExpeditionById(widget.expedition.id!);
                                                    },
                                                    child: Text("Tamam",
                                                        style: TextStyle(
                                                            color: isSuccess ? Colors.green : context.secondaryColor)),
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        }); */
                                      },
                                      child: const Text(
                                        "Onayla ve Devam Et",
                                        style:
                                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ).animate().fadeIn().scale().move(delay: 100.ms, duration: 300.ms)
                  : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}

class BusSeatTypesRow extends StatelessWidget {
  const BusSeatTypesRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BusSeatType(
          color: Color(0xFF6797C2),
          text: "Dolu - Erkek",
        ),
        const BusSeatType(
          color: Color(0xFFEEB1C0),
          text: "Dolu - Kadın",
        ),
        BusSeatType(
          color: Colors.white,
          text: "Boş Koltuk",
          border: Border.all(width: 0.5),
        ),
      ],
    );
  }
}
