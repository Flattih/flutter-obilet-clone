import 'package:cashback/core/constants/image_constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/features/home/notifiers/expedition_controller.dart';
import 'package:flutter/material.dart' hide FilterChip;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class FilterChip extends ConsumerWidget {
  final FilterType filterType;
  final String text;
  final VoidCallback onTap;
  final bool isHardCoded;
  final IconData hardCodedIcon;
  const FilterChip({
    required this.filterType,
    required this.text,
    required this.onTap,
    this.isHardCoded = false,
    this.hardCodedIcon = Icons.change_circle_outlined,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredStateList = ref.watch(filterChipProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: InkWell(
        onTap: () {
          onTap.call();
          ref.read(expeditionControllerProvider.notifier).filterByDate();
        },
        child: Chip(
          side: BorderSide(
              color: isHardCoded
                  ? Colors.transparent
                  : filteredStateList.contains(filterType)
                      ? Colors.transparent
                      : Colors.black),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isHardCoded
                  ? Icon(
                      hardCodedIcon,
                      color: Colors.white,
                      size: 20,
                    )
                  : const SizedBox.shrink(),
              isHardCoded ? const Gap(8) : const SizedBox.shrink(),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHardCoded
                        ? Colors.white
                        : filteredStateList.contains(filterType)
                            ? Colors.white
                            : Colors.black54),
              ),
            ],
          ),
          backgroundColor: isHardCoded
              ? context.primaryColor
              : (filteredStateList.contains(filterType) ? context.primaryColor : Colors.white),
        ),
      ),
    );
  }
}

final filterChipProvider = NotifierProvider<FilterChipNotifier, List<FilterType>>(FilterChipNotifier.new);

class FilterChipNotifier extends Notifier<List<FilterType>> {
  @override
  List<FilterType> build() {
    return [];
  }

  void addFilterOrRemove(FilterType filterType) {
    state = state.where((element) => element == filterType).isEmpty
        ? [...state, filterType]
        : state.where((element) => element != filterType).toList();
  }

  void clear() {
    state = [];
  }
}

class AnimatedFilterChip extends ConsumerStatefulWidget {
  final VoidCallback onTap;
  final String text;
  const AnimatedFilterChip({super.key, required this.onTap, required this.text});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AnimatedFilterChipState();
}

class _AnimatedFilterChipState extends ConsumerState<AnimatedFilterChip> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
          isExpanded ? widget.onTap.call() : null;
        },
        child: AnimatedSize(
          alignment: Alignment.centerLeft,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 800),
          child: Row(
            children: [
              ref.watch(orderByProvider).isEmpty
                  ? Chip(
                      label: Row(
                        children: [
                          isExpanded
                              ? const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )
                              : Image.asset(
                                  ImageConstants.upAndDownArrows,
                                  color: Colors.white,
                                  height: 20,
                                ),
                          isExpanded ? const SizedBox.shrink() : const Gap(8),
                          isExpanded
                              ? const SizedBox.shrink()
                              : Text(
                                  widget.text,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ],
                      ),
                      backgroundColor: context.primaryColor,
                    )
                  : const SizedBox.shrink(),
              isExpanded ? const Gap(8) : const SizedBox.shrink(),
              !isExpanded
                  ? const SizedBox.shrink()
                  : ref.watch(orderByProvider).isNotEmpty
                      ? Stack(
                          children: [
                            FilterChip(
                              filterType: FilterType.time,
                              text: ref.watch(orderByProvider),
                              onTap: () {
                                ref.read(expeditionControllerProvider.notifier).sortByPrice();
                              },
                            ),
                            Positioned(
                              right: 0,
                              top: 12,
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(orderByProvider.notifier).update((state) => "");
                                  ref.read(expeditionControllerProvider.notifier).sortByDate();
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: context.primaryColor),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            FilterChip(
                              filterType: FilterType.time,
                              text: 'Fiyata Göre',
                              onTap: () {
                                ref.read(expeditionControllerProvider.notifier).sortByPrice();
                                ref.read(orderByProvider.notifier).update((state) => "Fiyata Göre");
                              },
                            ),
                            FilterChip(
                              filterType: FilterType.price,
                              text: "Saate Göre",
                              onTap: () {
                                ref.read(expeditionControllerProvider.notifier).sortByDate();
                                ref.read(orderByProvider.notifier).update((state) => "Saate Göre");
                              },
                            ),
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }
}

final orderByProvider = StateProvider.autoDispose<String>((ref) => "");
