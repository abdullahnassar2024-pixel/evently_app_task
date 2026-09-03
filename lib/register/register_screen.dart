import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/model/my_user.dart';
import 'package:evently_app_task/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameController = TextEditingController(text: 'abdullah');
  var emailController = TextEditingController(text: 'abdullah@gmail.com');
  var passwordController = TextEditingController(text: '123456');
  var rePasswordController = TextEditingController(text: '123456');

  var formKey = GlobalKey<FormState>();

  bool isPasswordVisible = false;
  bool isRePasswordVisible = false;

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
                    AppLocalizations.of(context)!.create_your_account,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    filled: true,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your name ';
                      }
                      return null;
                    },
                    fillColor: themeProvider.isDark
                        ? AppColors.darkInputColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.name,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.person,
                      color: AppColors.lightGreyColor,
                    ),
                  ),
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    filled: true,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your email ';
                      }

                      final bool emailValid = RegExp(
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                      ).hasMatch(text);

                      if (!emailValid) {
                        return 'Please enter a valid email ';
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
                        return 'Please enter your password ';
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
                  CustomTextField(
                    borderColor: Theme.of(context).dividerColor,
                    filled: true,
                    controller: rePasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !isRePasswordVisible,
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter your password ';
                      }

                      if (text.length < 6) {
                        return 'Your password should be at least 6 chars.';
                      }

                      if (text != passwordController.text) {
                        return "Re-Password doesn't match Password.";
                      }

                      return null;
                    },
                    fillColor: themeProvider.isDark
                        ? AppColors.darkInputColor
                        : AppColors.whiteColor,
                    hintText: AppLocalizations.of(context)!.re_password,
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: AppColors.lightGreyColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isRePasswordVisible = !isRePasswordVisible;
                        });
                      },
                      icon: Icon(
                        isRePasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.lightGreyColor,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomElevatedButton(
                    onPressed: register,
                    verticalPadding: height * 0.01,
                    backgroundColor: Theme.of(context).cardColor,
                    child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: AppStyles.medium20White,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
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
                          AppLocalizations.of(context)!.sign_up_with_google,
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
        loadingText: 'Signing up with Google...',
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

  Future<void> register() async {
    if (formKey.currentState?.validate() == true) {
      try {
        DialogUtils.showLoading(context: context, loadingText: 'Waiting...');

        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        MyUser myUser = MyUser(
          id: credential.user?.uid ?? '',
          name: nameController.text,
          email: emailController.text,
        );

        await FirebaseUtils.addUserInFirestore(myUser);

        var userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.updateUser(myUser);

        DialogUtils.hideLoading(context: context);

        DialogUtils.showMessage(
          context: context,
          message: 'Register Successfully.',
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

        String message = e.message ?? 'Something went wrong';

        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is not valid.';
        }

        DialogUtils.showMessage(
          context: context,
          message: message,
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
