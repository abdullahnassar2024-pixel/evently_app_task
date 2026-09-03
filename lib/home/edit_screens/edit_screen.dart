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
import '../../utils/app_styles.dart';
import '../../utils/size_utils.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../tabs/home/add_event/date_or_time_widget.dart';
import '../tabs/home/tab_item_widget.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  String eventTitle = "";
  String eventDesciption = "";
  DateTime? selectedEventDate;
  TimeOfDay? selectedEventTime;
  String? formatedDate;
  String? formatedTime;
  String? selectedEventName = "";
  String? selectedEventImage = "";

  List<String> evenLightImagesList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.bookClub,
    AppAssets.exhibition,
  ];

  List<String> evenDarkImagesList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  int selectedIndex = 0;
  var formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  bool isInitialized = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  String getEventImage(AppThemeProvider themeProvider, int index) {
    return themeProvider.isDarkMode()
        ? evenDarkImagesList[index]
        : evenLightImagesList[index];
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

    Event event = args;
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var width = context.width;
    var height = context.height;

    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meetingM,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibitionE,
    ];

    if (!isInitialized) {
      isInitialized = true;

      selectedIndex = event.eventCategoryIndex - 1;

      if (selectedIndex < 0 || selectedIndex >= eventsNameList.length) {
        selectedIndex = 0;
      }

      titleController.text = event.eventTitle;
      descriptionController.text = event.eventDescription;

      eventTitle = event.eventTitle;
      eventDesciption = event.eventDescription;

      selectedEventDate = event.eventDate;
      selectedEventTime = TimeOfDay.fromDateTime(event.eventDate);

      formatedDate = DateFormat('dd/MM/yyyy').format(event.eventDate);
      formatedTime = DateFormat('hh:mm a').format(event.eventDate);
    }

    selectedEventName = eventsNameList[selectedIndex];
    selectedEventImage = getEventImage(themeProvider, selectedIndex);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.transparentColor,
        title: Text(
          AppLocalizations.of(context)!.editEvent,
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
                    selectedEventImage!,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            selectedEventImage = getEventImage(
                              themeProvider,
                              index,
                            );
                            selectedEventName = eventsNameList[index];
                          });
                        },
                        child: TabItemWidget(
                          isSelected: selectedIndex == index,
                          eventName: eventsNameList[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: width * 0.02);
                    },
                    itemCount: eventsNameList.length,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: titleController,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.title,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkBgColor
                      : AppColors.whiteColor,
                  borderColor: Theme.of(context).dividerColor,
                  onChanged: (text) {
                    eventTitle = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your title";
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.descriptionD,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: height * 0.02),
                CustomTextField(
                  controller: descriptionController,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                  hintText: AppLocalizations.of(context)!.descriptionD,
                  fillColor: themeProvider.isDarkMode()
                      ? AppColors.darkBgColor
                      : AppColors.whiteColor,
                  borderColor: Theme.of(context).dividerColor,
                  onChanged: (text) {
                    eventDesciption = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return "Please enter your description";
                    }
                    return null;
                  },
                  maxLines: 6,
                ),
                SizedBox(height: height * 0.02),
                DateOrTimeWidget(
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  chooseDateOrTime:
                      formatedDate ?? AppLocalizations.of(context)!.event_date,
                  onChooseDateOrTime: onChooseDate,
                ),
                DateOrTimeWidget(
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  icon: Icon(
                    Icons.timer_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  chooseDateOrTime:
                      formatedTime ?? AppLocalizations.of(context)!.event_time,
                  onChooseDateOrTime: onChooseTime,
                ),
                CustomElevatedButton(
                  verticalPadding: height * 0.01,
                  backgroundColor: Theme.of(context).cardColor,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    try {
                      DateTime eventDate = selectedEventDate ?? event.eventDate;

                      if (selectedEventTime != null) {
                        eventDate = DateTime(
                          eventDate.year,
                          eventDate.month,
                          eventDate.day,
                          selectedEventTime!.hour,
                          selectedEventTime!.minute,
                        );
                      }

                      Event updatedEvent = Event(
                        eventId: event.eventId,
                        eventImage: selectedEventImage!,
                        eventTitle: eventTitle.trim().isEmpty
                            ? event.eventTitle
                            : eventTitle.trim(),
                        eventDescription: eventDesciption.trim().isEmpty
                            ? event.eventDescription
                            : eventDesciption.trim(),
                        eventDate: eventDate,
                        eventCategoryIndex: selectedIndex + 1,
                        eventName: selectedEventName ?? event.eventName,
                        isFavourite: event.isFavourite,
                      );

                      await FirebaseUtils.getEventsCollections()
                          .doc(event.eventId)
                          .set(updatedEvent);

                      ToastUtils.showToastMessage(
                        message: AppLocalizations.of(context)!.updateSuccess,
                        backgroundColor: AppColors.greenColor,
                        textColor: AppColors.whiteColor,
                      );

                      Navigator.pop(context);
                    } catch (error) {
                      ToastUtils.showToastMessage(
                        message: AppLocalizations.of(context)!.noAction,
                        backgroundColor: AppColors.redColor,
                        textColor: AppColors.whiteColor,
                      );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.update,
                    style: AppStyles.medium20WhiteDarkColor,
                  ),
                ),
                SizedBox(height: height * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onChooseDate() async {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);

    bool isDark = themeProvider.isDarkMode();

    var chooseDate = await showDatePicker(
      context: context,
      initialDate: selectedEventDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.darkBgColor,
                    onSurface: AppColors.whiteColor,
                  )
                : ColorScheme.light(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.whiteColor,
                    onSurface: Colors.black,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainLightColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (chooseDate != null) {
      selectedEventDate = chooseDate;
      formatedDate = DateFormat('dd/MM/yyyy').format(chooseDate);
      setState(() {});
    }
  }

  void onChooseTime() async {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);

    bool isDark = themeProvider.isDarkMode();

    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedEventTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.darkBgColor,
                    onSurface: AppColors.whiteColor,
                  )
                : ColorScheme.light(
                    primary: AppColors.mainLightColor,
                    onPrimary: AppColors.whiteColor,
                    surface: AppColors.whiteColor,
                    onSurface: Colors.black,
                  ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.mainLightColor,
              ),
            ),
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: AppColors.greyColor,
              hourMinuteColor: AppColors.greyColor,
              hourMinuteTextColor: isDark ? AppColors.whiteColor : Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (chooseTime != null) {
      selectedEventTime = chooseTime;
      formatedTime = chooseTime.format(context);
      setState(() {});
    }
  }
}
