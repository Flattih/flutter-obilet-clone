import 'package:cashback/core/constants/constants.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.secondaryColor,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: context.secondaryColor,
              child: Column(
                children: [
                  Text(
                    "YARDIM",
                    style: context.textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0, horizontal: 50),
                    child: TextField(
                      decoration: InputDecoration(
                        constraints: const BoxConstraints(
                          maxHeight: 45,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: Icon(Icons.search, color: context.secondaryColor),
                        ),
                        hintText: "Nasıl yardımcı olabiliriz?",
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ColoredBox(
              color: Colors.grey.shade200,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20).copyWith(bottom: 50),
                itemCount: helpItems.length,
                itemBuilder: (context, index) {
                  final helpItemTitle = helpItems[index]["title"];
                  final helpItemLeading = helpItems[index]["leading"];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 22.0),
                    child: Material(
                      elevation: 2,
                      child: ListTile(
                        leading: Image.asset(
                          helpItemLeading!,
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                        title: Text(helpItemTitle!,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                        subtitle: const Text("Sıkça Sorulan Sorular"),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                        ),
                      ),
                    ),
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
