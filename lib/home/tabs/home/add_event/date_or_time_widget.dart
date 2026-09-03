
 import 'package:flutter/material.dart';

import '../../../../utils/size_utils.dart';

class DateOrTimeWidget extends StatelessWidget {
  final Widget icon;
  final String eventDateOrTime;
  final String chooseDateOrTime;
  final VoidCallback onChooseDateOrTime;
  const DateOrTimeWidget({super.key , required this.icon, required this.eventDateOrTime, required this.onChooseDateOrTime,required this.chooseDateOrTime});

  @override
  Widget build(BuildContext context) {
    var width = context.width;

    return Row(
      spacing: width*0.02,
      children: [
        icon ,
        Text( eventDateOrTime,
        style: Theme.of(context).textTheme.headlineMedium,
        ),
        Spacer(),
        TextButton(onPressed: onChooseDateOrTime, child: Text(chooseDateOrTime,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: Theme.of(context).cardColor
        ),
        ))
      ],
    );
  }
}
