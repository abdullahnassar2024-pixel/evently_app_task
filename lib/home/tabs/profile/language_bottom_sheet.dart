
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
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
              //todo: change language to english
              languageProvider.changeLanguage('en');
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedLanguageItem(
                    language: AppLocalizations.of(context)!.english,
                  )
                : getUnSelectedLanguageItem(
                    language: AppLocalizations.of(context)!.english,
                  ),
          ),

          InkWell(
            onTap: () {
              //todo: change language to arabic
              languageProvider.changeLanguage('ar');
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedLanguageItem(
                    language: AppLocalizations.of(context)!.arabic,
                  )
                : getUnSelectedLanguageItem(
                    language: AppLocalizations.of(context)!.arabic,
                  ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedLanguageItem({required String language}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(language, style: AppStyles.semi24MainLightColor),
        Icon(Icons.check, size: 30, color: AppColors.mainLightColor),
      ],
    );
  }

  Widget getUnSelectedLanguageItem({required String language}) {
    return Text(language, style: AppStyles.medium16Black);
  }
}
