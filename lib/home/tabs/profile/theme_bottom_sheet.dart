
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';


class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        spacing: height * 0.04,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              //todo: change theme to dark
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: themeProvider.isDark
                ? getSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.dark,
                  )
                : getUnSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.dark,
                  ),
          ),

          InkWell(
            onTap: () {
              //todo: change theme to light
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: !(themeProvider.isDark)
                ? getSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.light,
                  )
                : getUnSelectedThemeItem(
                    theme: AppLocalizations.of(context)!.light,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedThemeItem({required String theme}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(theme, style: AppStyles.semi24MainLightColor),
        Icon(Icons.check, size: 30, color: AppColors.mainLightColor),
      ],
    );
  }

  Widget getUnSelectedThemeItem({required String theme}) {
    return Text(theme, style: AppStyles.medium16Black);
  }
}
