import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:cashback/features/home/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class FromToWidget extends StatelessWidget {
  const FromToWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: context.paddingLow,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.paddingNormal.copyWith(left: 0, right: 14),
            child: Column(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                for (var i = 0; i < 5; i++)
                  Container(
                    height: 5,
                    width: 5,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                const Icon(Icons.location_on, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final travelModel = ref.watch(homeControllerProvider);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("NEREDEN", style: TextStyle(color: context.secondaryColor, fontWeight: FontWeight.bold)),
                      const Gap(3),
                      InkWell(
                          onTap: () {
                            context.toNamed(SearchScreen.routeName, arguments: true);
                          },
                          child: Text(travelModel.from, style: const TextStyle(fontWeight: FontWeight.w500))),
                      Row(
                        children: [
                          Expanded(
                            flex: 12,
                            child: SizedBox(
                              height: 2,
                              child: Divider(
                                color: Colors.grey.withOpacity(0.3),
                                thickness: 1,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(homeControllerProvider.notifier).swap();
                            },
                            child: Container(
                              padding: context.paddingLow / 2,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Image.asset(ImageConstants.upAndDownArrows),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 2,
                              child: Divider(
                                color: Colors.grey.withOpacity(0.3),
                                thickness: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(3),
                      Text("NEREYE", style: TextStyle(color: context.secondaryColor, fontWeight: FontWeight.bold)),
                      const Gap(3),
                      InkWell(
                          onTap: () {
                            context.toNamed(SearchScreen.routeName, arguments: false);
                          },
                          child: Text(travelModel.to, style: const TextStyle(fontWeight: FontWeight.w500))),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
