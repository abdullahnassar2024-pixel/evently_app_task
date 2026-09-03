import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../model/event.dart';
import '../../providers/app_theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/size_utils.dart';

class DetailsEventScreen extends StatefulWidget {
  const DetailsEventScreen({super.key});

  @override
  State<DetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<DetailsEventScreen> {
  var formKey = GlobalKey<FormState>();

  String getEventImage(BuildContext context, Event event) {
    final bool isDark = Provider.of<AppThemeProvider>(context).isDarkMode();

    switch (event.eventCategoryIndex) {
      case 1:
        return isDark ? AppAssets.sportDark : AppAssets.sport;
      case 2:
        return isDark ? AppAssets.birthdayDark : AppAssets.birthday;
      case 3:
        return isDark ? AppAssets.meetingDark : AppAssets.meeting;
      case 4:
        return isDark ? AppAssets.bookClubDark : AppAssets.bookClub;
      case 5:
        return isDark ? AppAssets.exhibitionDark : AppAssets.exhibition;
      default:
        return isDark ? AppAssets.sportDark : AppAssets.sport;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! Event) {
      return const Scaffold(
        body: Center(
          child: Text("No Event Data Found!", textAlign: TextAlign.center),
        ),
      );
    }

    final Event event = args;
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final width = context.width;
    final height = context.height;

    final String formattedDate = DateFormat(
      'dd MMMM yyyy',
    ).format(event.eventDate);
    final String formattedTime = DateFormat('hh:mm a').format(event.eventDate);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.details,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * .02,
            top: height * .01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: themeProvider.isDarkMode()
                ? AppColors.darkBgColor
                : AppColors.whiteColor,
            border: Border.all(color: Theme.of(context).dividerColor, width: 2),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(
              start: width * .02,
              top: height * .01,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeProvider.isDarkMode()
                  ? AppColors.darkBgColor
                  : AppColors.whiteColor,
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 2,
              ),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.editEventRouteName, arguments: event);
              },
              icon: Icon(
                Icons.edit_outlined,
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              margin: EdgeInsetsDirectional.only(
                start: width * .02,
                top: height * .01,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: themeProvider.isDarkMode()
                    ? AppColors.darkBgColor
                    : AppColors.whiteColor,
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: 2,
                ),
              ),
              child: IconButton(
                onPressed: () async {
                  try {
                    await FirebaseUtils.getEventsCollections()
                        .doc(event.eventId)
                        .delete();

                    if (!context.mounted) return;

                    ToastUtils.showToastMessage(
                      message: AppLocalizations.of(context)!.delete,
                      backgroundColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                    );

                    Navigator.of(context).pop();
                  } catch (error) {
                    if (!context.mounted) return;

                    ToastUtils.showToastMessage(
                      message: AppLocalizations.of(context)!.noAction,
                      backgroundColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                    );
                  }
                },
                icon: Icon(Icons.delete_outline, color: AppColors.redColor),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Image.asset(
                    height: height * 0.25,
                    getEventImage(context, event),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  event.eventTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode()
                        ? AppColors.transparentColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: themeProvider.isDarkMode()
                              ? AppColors.transparentColor
                              : AppColors.strokeWhiteColor,
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          size: height * 0.04,
                          Icons.date_range_sharp,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(height: height * 0.005),
                          Text(
                            formattedTime,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.descriptionD,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 120),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode()
                        ? AppColors.transparentColor
                        : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    event.eventDescription.isEmpty
                        ? "No Description"
                        : event.eventDescription,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
