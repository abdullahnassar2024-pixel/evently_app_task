
import 'package:flutter/material.dart';

import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';

class TabItemWidget extends StatelessWidget {
  final bool isSelected ;
  final String eventName ;
  const TabItemWidget({super.key,required this.isSelected ,required this.eventName});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width*0.04,
        vertical: height*0.01
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? Theme.of(context).cardColor : Theme.of(context).highlightColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        )
      ),
      child: Text(eventName,
      style: isSelected ? AppStyles.medium16White :
      Theme.of(context).textTheme.headlineMedium,
        ),
    );
  }
}
