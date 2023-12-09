import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/auth/notifiers/auth_controller.dart';
import 'package:cashback/features/my_travels/notifiers/my_travels_controller.dart';
import 'package:cashback/features/my_travels/widgets/travel_ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyTravelsScreen extends ConsumerStatefulWidget {
  static const routeName = "/my-travels";
  const MyTravelsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyTravelsScreenState();
}

class _MyTravelsScreenState extends ConsumerState<MyTravelsScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: context.primaryColor,
        title: const Text(
          "Seyahatlerim",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          TabBar(
            labelColor: context.primaryColor,
            indicatorColor: context.primaryColor,
            indicatorWeight: 3.5,
            unselectedLabelColor: Colors.grey,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 13),
            controller: tabController,
            tabs: const [
              Tab(
                text: "Otobüs",
              ),
              Tab(
                text: "Uçak",
              ),
              Tab(
                text: "Otel",
              ),
              Tab(
                text: "Feribot",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(controller: tabController, children: [
              ref.watch(myTravelsController).when(
                    data: (expeditions) => expeditions.isEmpty
                        ? const Center(
                            child: Text("Seyahat bulunamadı"),
                          )
                        : ListView.builder(
                            padding: (context.paddingNormal / 2).copyWith(top: 30),
                            itemCount: expeditions.length,
                            itemBuilder: (context, index) {
                              final expedition = expeditions[index];
                              if (index == 0) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    TravelTicket(
                                      id: expedition.id ?? "HATA",
                                      departurePlace: expedition.departurePlace ?? "HATA",
                                      destinationPlace: expedition.destinationPlace ?? "HATA",
                                      seatNoList: expedition.busSeatNumbers
                                              ?.where((busSeatNumber) =>
                                                  busSeatNumber.userId == ref.read(userProvider)!.uid)
                                              .toList() ??
                                          [],
                                      price: expedition.price ?? "HATA",
                                      departureTime: expedition.departureTime ?? DateTime.now(),
                                    ),
                                    const InformationHeader(
                                      title: "GEÇMİŞ TARİHLİ BİLETLERİM",
                                    ),
                                  ],
                                );
                              } else {
                                return TravelTicket(
                                  id: expedition.id ?? "HATA",
                                  departurePlace: expedition.departurePlace ?? "HATA",
                                  destinationPlace: expedition.destinationPlace ?? "HATA",
                                  seatNoList: expedition.busSeatNumbers
                                          ?.where(
                                              (busSeatNumber) => busSeatNumber.userId == ref.read(userProvider)!.uid)
                                          .toList() ??
                                      [],
                                  price: expedition.price ?? "HATA",
                                  departureTime: expedition.departureTime ?? DateTime.now(),
                                );
                              }
                            },
                          ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                  ),
              const Text("Uçak"),
              const Text("Otel"),
              const Text("Feribot"),
            ]),
          ),
        ],
      ),
    );
  }
}

class InformationHeader extends StatelessWidget {
  final String title;
  const InformationHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.primaryColor),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
