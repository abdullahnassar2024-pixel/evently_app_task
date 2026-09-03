 import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/model/event.dart';
import 'package:evently_app_task/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../providers/app_language_provider.dart';
import '../../../providers/app_theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/size_utils.dart';
import 'event_item_widget.dart';
import 'tab_item_widget.dart';

class HomeTab extends StatefulWidget {
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;
  List<Event> eventsList = [];

  Stream<List<Event>>? eventStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    eventStream = FirebaseUtils.getAllEvents();
  }
  void updateStream(int index){
    selectedIndex = index;
    if(selectedIndex == 0){
      //eventStream = getAllEvents();
      eventStream =FirebaseUtils.getAllEvents();
    }else{
      //eventStream = getFilterEvents();
      eventStream =FirebaseUtils.getFilterEvents(selectedIndex: selectedIndex);
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    List<String> eventsNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.exhibition,
    ];

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.04,
        ),
        child: DefaultTabController(
          length: eventsNameList.length,
          child: Column(
            spacing: height * 0.02,
            children: [
              Row(
                spacing: width * 0.04,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: height * 0.01,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.welcome_back,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        userProvider.currentUser!.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    themeProvider.isDark
                        ? Icons.brightness_2_outlined
                        : Icons.light_mode_outlined,
                    color: Theme.of(context).cardColor,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Text(
                      languageProvider.appLanguage.toUpperCase(),
                      style: AppStyles.semi14White,
                    ),
                  ),
                ],
              ),
              TabBar(
                isScrollable: true,
                onTap: (index) {
                   updateStream(index);
                },
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
                tabAlignment: TabAlignment.start,
                indicatorColor: AppColors.transparentColor,
                dividerColor: AppColors.transparentColor,
                tabs: eventsNameList.map((eventName) {
                  return TabItemWidget(
                    isSelected:
                        selectedIndex == eventsNameList.indexOf(eventName),
                    eventName: eventName,
                  );
                }).toList(),
              ),
              Expanded(
                child: StreamBuilder<List<Event>>(
                  stream: eventStream,
                  builder: (context, snapshot) {
                    //todo : loading =>
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainLightColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          snapshot.error.toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      );
                    } else if (!snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_event_found,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      );
                    } else {
                      eventsList = snapshot.data!;

                      return  eventsList.isEmpty ?
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_event_found,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )

                          :
                        ListView.separated(
                        itemBuilder: (context, index) {
                          return EventItemWidget(event: eventsList[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: height * 0.02);
                        },
                        itemCount: eventsList.length,

                      );



                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 


}
