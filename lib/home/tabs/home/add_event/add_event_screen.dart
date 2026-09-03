
import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/model/event.dart';
import 'package:evently_app_task/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../providers/app_theme_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/size_utils.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../tab_item_widget.dart';
import 'date_or_time_widget.dart';

class AddEventScreen extends StatefulWidget {
  AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  List<String> eventLightImagesList = [
    AppAssets.sport,
    AppAssets.birthday,
    AppAssets.meeting,
    AppAssets.bookClub,
    AppAssets.exhibition,
  ];

  List<String> eventDarkImagesList = [
    AppAssets.sportDark,
    AppAssets.birthdayDark,
    AppAssets.meetingDark,
    AppAssets.bookClubDark,
    AppAssets.exhibitionDark,
  ];

  int selectedIndex = 0;
  DateTime? selectedDate;
  String formatDate = '';
  TimeOfDay? selectedTime;
  String formatTime = '';
  var formKey = GlobalKey<FormState>();
  var title = '';
  var description = '';
  String selectedEventImage = '';
  String selectedEventName = '';
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      var themeProvider = Provider.of<AppThemeProvider>(context);

      selectedEventImage = themeProvider.isDark
          ? eventDarkImagesList[selectedIndex]
          : eventLightImagesList[selectedIndex];

      selectedEventName = AppLocalizations.of(context)!.sport;

      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    List<String> eventsNameList = [
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparentColor,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsetsDirectional.only(
            start: width * 0.02,
            top: height * 0.01,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).highlightColor,
            border: Border.all(width: 2, color: Theme.of(context).dividerColor),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.add_event,
          style: Theme.of(context).textTheme.titleSmall,
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
              spacing: height * 0.02,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: height * 0.23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Theme.of(context).dividerColor),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(selectedEventImage),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          var themeProvider = Provider.of<AppThemeProvider>(
                            context,
                            listen: false,
                          );

                          selectedIndex = index;
                          selectedEventName = eventsNameList[index];

                          selectedEventImage = themeProvider.isDark
                              ? eventDarkImagesList[index]
                              : eventLightImagesList[index];

                          setState(() {});
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
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  borderColor: Theme.of(context).dividerColor,
                  hintText: AppLocalizations.of(context)!.please_enter_title,
                  onChanged: (text) {
                    title = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter Event Title ';
                    }
                    return null;
                  },
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  AppLocalizations.of(context)!.descriptionD,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CustomTextField(
                  filled: true,
                  fillColor: Theme.of(context).highlightColor,
                  borderColor: Theme.of(context).dividerColor,
                  maxLines: 5,
                  onChanged: (text) {
                    description = text;
                  },
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter Event Description ';
                    }
                    return null;
                  },
                  hintText: AppLocalizations.of(
                    context,
                  )!.please_enter_description,
                  hintStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                DateOrTimeWidget(
                  icon: Icon(
                    Icons.date_range_outlined,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.event_date,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.choose_date
                      : formatDate,
                  onChooseDateOrTime: onChooseDate,
                ),
                DateOrTimeWidget(
                  icon: Icon(
                    Icons.access_time,
                    color: Theme.of(context).cardColor,
                  ),
                  eventDateOrTime: AppLocalizations.of(context)!.event_time,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.choose_time
                      : formatTime,
                  onChooseDateOrTime: onChooseTime,
                ),
                CustomElevatedButton(
                  verticalPadding: height * 0.011,
                  backgroundColor: Theme.of(context).cardColor,
                  onPressed: addEvent,
                  child: Text(
                    AppLocalizations.of(context)!.add_event,
                    style: AppStyles.medium20White,
                  ),
                ),
                SizedBox(height: height * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addEvent() {
    if (formKey.currentState?.validate() == true) {
      if (selectedDate == null || selectedTime == null) {
        ToastUtils.showToastMessage(
          message: 'Please choose date and time',
          backgroundColor: AppColors.mainLightColor,
          textColor: AppColors.whiteColor,
        );
        return;
      }

      Event event = Event(
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTitle: title,
        eventDescription: description,
        eventCategoryIndex: selectedIndex + 1,
        eventDate: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
      );

      FirebaseUtils.addEventInFireStore(event)
          .then((value) {
            ToastUtils.showToastMessage(
              message: 'Event Add Successfully',
              backgroundColor: AppColors.mainLightColor,
              textColor: AppColors.whiteColor,
            );
            Navigator.pop(context);
          })
          .catchError((error) {
            ToastUtils.showToastMessage(
              message: error.toString(),
              backgroundColor: AppColors.mainLightColor,
              textColor: AppColors.whiteColor,
            );
          });
    }
  }

  void onChooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (chooseDate != null) {
      selectedDate = chooseDate;
      formatDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      setState(() {});
    }
  }

  void onChooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (chooseTime != null) {
      selectedTime = chooseTime;
      formatTime = selectedTime!.format(context);
      setState(() {});
    }
  }
}
