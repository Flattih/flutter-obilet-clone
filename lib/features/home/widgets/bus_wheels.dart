import 'package:flutter/material.dart';

class BusWheels extends StatelessWidget {
  const BusWheels({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
        ),
      ],
    );
  }
}
