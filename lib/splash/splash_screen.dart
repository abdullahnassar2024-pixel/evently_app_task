import 'package:evently_app_task/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_theme_provider.dart';
import '../providers/user_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      final user = await FirebaseUtils.readUsersFromFirestore(currentUser.uid);

      if (user != null) {
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.updateUser(user);

        if (!mounted) return;

        Navigator.pushReplacementNamed(context, AppRoutes.homeRouteName);
        return;
      }
    }

    Navigator.pushReplacementNamed(context, AppRoutes.onboardingRouteName);
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 240),
          Center(
            child: Image.asset(
              isDarkMode
                  ? AppAssets.eventlySplashDark
                  : AppAssets.eventlySplashLight,
            ),
          ),
          const SizedBox(height: 120),
          Image.asset(AppAssets.routeLogoSplash),
        ],
      ),
    );
  }
}
