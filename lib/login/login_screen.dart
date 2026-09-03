import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:evently_app_task/model/my_user.dart';
import '../l10n/app_localizations.dart';
import '../providers/app_theme_provider.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_routes.dart';
import '../utils/app_styles.dart';
import '../utils/dialog_utils.dart';
import '../utils/size_utils.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController(text: 'abdullah@gmail.com');
  var passwordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                spacing: height * 0.02,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    themeProvider.isDark
                        ? AppAssets.logoDarkImage
                        : AppAssets.logoLightImage,
                  ),
                  Text(
                    AppLocalizations.of(context)!.login_to_your_account,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    filled: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      final bool emailValid = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      ).hasMatch(text);

                      if (!emailValid) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                    fillColor: themeProvider.isDark
                        ? AppColors.darkInputColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.email,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    filled: true,
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isPasswordVisible,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your password';
                      }

                      if (text.length < 6) {
                        return 'Your password should be at least 6 chars.';
                      }

                      return null;
                    },
                    fillColor: themeProvider.isDark
                        ? AppColors.darkInputColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.lightGreyColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.lightGreyColor,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          AppLocalizations.of(context)!.forgetPassword,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Theme.of(context).cardColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: login,
                    verticalPadding: height * 0.01,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.do_not_have_an_account,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.registerRouteName);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signup,
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Theme.of(context).cardColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context).dividerColor,
                          indent: width * 0.01,
                          endIndent: width * 0.04,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.or,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Theme.of(context).dividerColor,
                          indent: width * 0.01,
                          endIndent: width * 0.04,
                        ),
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    onPressed: signInWithGoogle,
                    verticalPadding: height * 0.02,
                    borderColor: Theme.of(context).dividerColor,
                    backgroundColor: themeProvider.isDark
                        ? AppColors.darkInputColor
                        : AppColors.whiteColor,
                    child: Row(
                      spacing: width * 0.04,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.googleLogo),
                        Text(
                          AppLocalizations.of(context)!.login_with_google,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    try {
      DialogUtils.showLoading(
        context: context,
        loadingText: 'Signing in with Google...',
      );

      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      final String? idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        DialogUtils.hideLoading(context: context);
        return;
      }

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User? firebaseUser = userCredential.user;

      if (firebaseUser == null) {
        DialogUtils.hideLoading(context: context);
        return;
      }

      MyUser? myUser = await FirebaseUtils.readUsersFromFirestore(
        firebaseUser.uid,
      );

      if (myUser == null) {
        myUser = MyUser(
          id: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
        );

        await FirebaseUtils.addUserInFirestore(myUser);
      }

      final userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.updateUser(myUser);

      DialogUtils.hideLoading(context: context);

      if (!mounted) return;

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.homeRouteName, (route) => false);
    } on GoogleSignInException catch (e) {
      DialogUtils.hideLoading(context: context);

      if (!mounted) return;

      DialogUtils.showMessage(
        context: context,
        message: e.description ?? 'Google Sign-In failed.',
        title: 'Error',
        posActionName: 'Ok',
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideLoading(context: context);

      if (!mounted) return;

      DialogUtils.showMessage(
        context: context,
        message: e.message ?? 'Google authentication failed.',
        title: 'Error',
        posActionName: 'Ok',
      );
    } catch (e) {
      DialogUtils.hideLoading(context: context);

      if (!mounted) return;

      DialogUtils.showMessage(
        context: context,
        message: e.toString(),
        title: 'Error',
        posActionName: 'Ok',
      );
    }
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, loadingText: 'Loading...');

        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text,
            );

        var user = await FirebaseUtils.readUsersFromFirestore(
          credential.user?.uid ?? '',
        );

        if (user == null) {
          DialogUtils.hideLoading(context: context);
          return;
        }

        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.updateUser(user);

        DialogUtils.hideLoading(context: context);

        DialogUtils.showMessage(
          context: context,
          message: 'Login Successfully.',
          title: 'Success',
          posActionName: 'Ok',
          posAction: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.homeRouteName,
              (route) => false,
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideLoading(context: context);

        String errorMessage = 'Login failed';

        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-credential') {
          errorMessage =
              'Invalid login credentials. Please check your email and password.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The email address is not valid.';
        }

        DialogUtils.showMessage(
          context: context,
          message: errorMessage,
          title: 'Error',
          posActionName: 'Ok',
        );
      } catch (e) {
        DialogUtils.hideLoading(context: context);

        DialogUtils.showMessage(
          context: context,
          message: e.toString(),
          title: 'Error',
          posActionName: 'Ok',
        );
      }
    }
  }
}
