
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/size_utils.dart';

class  ProfileItemWidget extends StatelessWidget {

  final String text;
  final Widget item;
  const  ProfileItemWidget({super.key ,required this.text,required this.item});

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: themeProvider.isDark ? AppColors.darkInputColor : AppColors.whiteColor,
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 2,
        )
      ),
      child: ListTile(
        title: Text(text,
        style:Theme.of(context).textTheme.headlineMedium ,),
        trailing:item ,

      ),
    );
  }
}
