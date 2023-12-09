import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/mixin/search_screen_mixin.dart';
import 'package:cashback/features/home/notifiers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final bool isFrom;
  static const routeName = '/search-screen';
  const SearchScreen({super.key, required this.isFrom});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> with SearchScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: context.secondaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: context.secondaryColor,
              padding: context.paddingLow.copyWith(bottom: 15),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "NEREDEN",
                        style: context.textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const Gap(5),
                  Padding(
                    padding: context.paddingLowHorizontal,
                    child: TextField(
                      onChanged: searchCity,
                      controller: searchController,
                      style: const TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: context.secondaryColor,
                        filled: true,
                        hintText: "İl adı giriniz",
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey.shade300,
              width: double.infinity,
              padding: context.paddingLow.copyWith(left: 19),
              child: Text("En Çok Kullanılan Duraklar",
                  style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: turkishCitiesState.length,
                itemBuilder: (context, index) {
                  final city = turkishCitiesState[index];
                  return ListTile(
                    onTap: () {
                      if (widget.isFrom) {
                        ref.read(homeControllerProvider.notifier).updateFrom(city);
                      } else {
                        ref.read(homeControllerProvider.notifier).updateTo(city);
                      }
                      context.pop();
                    },
                    horizontalTitleGap: 0,
                    dense: true,
                    leading: const Icon(Icons.location_on),
                    title: Text(city,
                        style:
                            context.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
