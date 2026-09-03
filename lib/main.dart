import 'package:evently_app_task/providers/app_language_provider.dart';
import 'package:evently_app_task/providers/app_theme_provider.dart';
import 'package:evently_app_task/providers/user_provider.dart';
import 'package:evently_app_task/utils/app_routes.dart';
import 'package:evently_app_task/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'firebase_utils.dart';
import 'home/edit_screens/details_screen.dart';
import 'home/edit_screens/edit_screen.dart';
import 'l10n/app_localizations.dart';
import 'forget_pass_screen/forget_pass_screen.dart';
import 'home/home_screen.dart';
import 'home/tabs/home/add_event/add_event_screen.dart';
import 'login/login_screen.dart';
import 'onboarding/onboarding_main.dart';
import 'onboarding/onboarding_moving.dart';
import 'register/register_screen.dart';
import 'splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GoogleSignIn.instance.initialize(
    serverClientId: FirebaseUtils.googleServerClientId,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRouteName,
      routes: {
        AppRoutes.splashRouteName: (context) => SplashScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingMain(),
        AppRoutes.onboardingMovingRouteName: (context) => OnboardingScreen(),
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.addEventRouteName: (context) => AddEventScreen(),
        AppRoutes.forgetPassRouteName: (context) => ForgetPassScreen(),
        AppRoutes.editEventRouteName: (context) => EditEventScreen(),
        AppRoutes.eventDetailsRouteName: (context) => DetailsEventScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.isDarkMode() ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
