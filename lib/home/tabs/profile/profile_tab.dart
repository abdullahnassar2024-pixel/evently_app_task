
import 'package:evently_app_task/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_assets.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_utils.dart';
import 'language_bottom_sheet.dart';
import 'widgets/build_profile_item.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.04,
        horizontal: width * 0.04,
      ),
      child: SafeArea(
        child: Column(
          spacing: height * 0.02,
          children: [
            Image.asset(AppAssets.profilePic),
            Text(
              userProvider.currentUser!.name,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              userProvider.currentUser!.email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            ProfileItemWidget(
              text: AppLocalizations.of(context)!.dark,
              item: Switch(
                activeThumbColor: AppColors.whiteColor,
                inactiveThumbColor: AppColors.whiteColor,
                activeTrackColor: AppColors.mainDarkColor,
                inactiveTrackColor: AppColors.lightGreyColor,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.transparentColor;
                  }
                  return AppColors.whiteColor;
                }),
                value: themeProvider.isDark,
                onChanged: (value) {
                  themeProvider.changeTheme(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
                },
              ),
            ),
            ProfileItemWidget(
              text: AppLocalizations.of(context)!.language,
              item: IconButton(
                onPressed: () {
                  showLanguageBottomSheet();
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 25,
                  color: AppColors.mainLightColor,
                ),
              ),
            ),
            ProfileItemWidget(
              text: AppLocalizations.of(context)!.logout,
              item: IconButton(
                onPressed: logout,
                icon: Icon(Icons.logout, size: 25, color: AppColors.redColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();

    var userProvider = Provider.of<UserProvider>(context, listen: false);

    userProvider.clearUser();

    if (!mounted) return;

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.loginRouteName, (route) => false);
  }
}
