import 'package:cashback/core/constants/constants.dart';
import 'package:cashback/features/home/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin SearchScreenMixin on ConsumerState<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  List<String> turkishCitiesState = turkishCities;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchCity(String query) {
    if (query.isEmpty) {
      setState(() {
        turkishCitiesState = turkishCities;
      });
      return;
    }

    final filteredCities =
        turkishCitiesState.where((city) => city.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      turkishCitiesState = filteredCities;
    });
  }
}
