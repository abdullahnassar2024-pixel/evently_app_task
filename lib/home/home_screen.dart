import 'package:evently_app_task/home/tabs/favorite/favorite_tab.dart';
import 'package:evently_app_task/home/tabs/home/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_language_provider.dart';
import '../providers/app_theme_provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import 'tabs/profile/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [HomeTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          _builtBottomNavBarItem(
            selectedIcon: Icon(Icons.home),
            unSelectedIcon: Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.home,
            isSelected: selectedIndex == 0,
          ),
          _builtBottomNavBarItem(
            selectedIcon: Icon(Icons.favorite),
            unSelectedIcon: Icon(Icons.favorite_border_outlined),
            label: AppLocalizations.of(context)!.favorite,
            isSelected: selectedIndex == 1,
          ),
          _builtBottomNavBarItem(
            selectedIcon: Icon(Icons.person),
            unSelectedIcon: Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.profile,
            isSelected: selectedIndex == 2,
          ),
        ],
      ),
      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo: navigate to  add event screen
          Navigator.of(context).pushNamed(AppRoutes.addEventRouteName);
        },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 25),
      ),
    );
  }

  BottomNavigationBarItem _builtBottomNavBarItem({
    required Widget selectedIcon,
    required Widget unSelectedIcon,
    required String label,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected ? selectedIcon : unSelectedIcon,
      label: label,
    );
  }
}
