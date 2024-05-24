import 'package:cashback/app_startup.dart';
import 'package:cashback/core/extension/context_extension.dart';
import 'package:cashback/core/constants/shared_pref_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RememberMeCheckbox extends ConsumerStatefulWidget {
  const RememberMeCheckbox({super.key});

  @override
  ConsumerState<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends ConsumerState<RememberMeCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = ref.read(sharedPreferencesProvider).requireValue.getBool(SharedKeys.rememberMe) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Checkbox(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
            value: _isChecked,
            onChanged: (value) async {
              await ref.read(sharedPreferencesProvider).requireValue.setBool(SharedKeys.rememberMe, value!);
              setState(() {
                _isChecked = value;
              });
            },
          ),
        ),
        Text("Beni Hatırla", style: context.textTheme.bodyLarge),
      ],
    );
  }
}
