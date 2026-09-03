// import 'package:evently_app_task/firebase_utils.dart';
// import 'package:evently_app_task/model/event.dart';
// import 'package:evently_app_task/utils/app_colors.dart';
// import 'package:evently_app_task/utils/toast_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
//  import '../../../utils/size_utils.dart';
//
// class EventItemWidget extends StatelessWidget {
//   final Event event;
//   const EventItemWidget({super.key, required this.event});
//
//   @override
//   Widget build(BuildContext context) {
//     var width = context.width;
//     var height = context.height;
//     return Container(
//       height: height * 0.23,
//       padding: EdgeInsets.symmetric(
//         vertical: height * 0.01,
//         horizontal: width * 0.02,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(width: 2, color: Theme.of(context).dividerColor),
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: AssetImage(event.eventImage),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.02,
//               vertical: height * 0.01,
//             ),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Text(
//               DateFormat('dd MMM').format(event.eventDate).toString(),
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     event.eventTitle,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     // todo : add to favorite item
//                     FirebaseUtils.updateIsFavourite(event).then( (value){
//                       ToastUtils.showToastMessage(
//                           message:  'Event Updated Successfully.',
//                           backgroundColor: AppColors.greenColor,
//                           textColor: AppColors.whiteColor
//                       );
//                     }).catchError((error){
//                       ToastUtils.showToastMessage(
//                           message:  error.toString(),
//                           backgroundColor: AppColors.greenColor,
//                           textColor: AppColors.whiteColor
//                       );
//                     });
//                   },
//                   icon: Icon(
//                     event.isFavourite ?
//                     Icons.favorite
//                         :
//                     Icons.favorite_border_outlined,
//                     color: Theme.of(context).cardColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///
// import 'package:evently_app_task/firebase_utils.dart';
// import 'package:evently_app_task/model/event.dart';
// import 'package:evently_app_task/utils/app_assets.dart';
// import 'package:evently_app_task/utils/app_colors.dart';
// import 'package:evently_app_task/utils/toast_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import '../../../utils/size_utils.dart';
//
// class EventItemWidget extends StatelessWidget {
//   final Event event;
//
//   const EventItemWidget({super.key, required this.event});
//
//   String getEventImage(BuildContext context) {
//     bool isDark = Theme.of(context).brightness == Brightness.dark;
//
//     switch (event.eventCategoryIndex) {
//       case 1:
//         return isDark ? AppAssets.sportDark : AppAssets.sport;
//       case 2:
//         return isDark ? AppAssets.birthdayDark : AppAssets.birthday;
//       case 3:
//         return isDark ? AppAssets.meetingDark : AppAssets.meeting;
//       case 4:
//         return isDark ? AppAssets.bookClubDark : AppAssets.bookClub;
//       case 5:
//         return isDark ? AppAssets.exhibitionDark : AppAssets.exhibition;
//       default:
//         return isDark ? AppAssets.sportDark : AppAssets.sport;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = context.width;
//     var height = context.height;
//
//     return Container(
//       height: height * 0.23,
//       padding: EdgeInsets.symmetric(
//         vertical: height * 0.01,
//         horizontal: width * 0.02,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(width: 2, color: Theme.of(context).dividerColor),
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: AssetImage(getEventImage(context)),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.02,
//               vertical: height * 0.01,
//             ),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Text(
//               DateFormat('dd MMM').format(event.eventDate),
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     event.eventTitle,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     FirebaseUtils.updateIsFavourite(event)
//                         .then((value) {
//                           ToastUtils.showToastMessage(
//                             message: 'Event Updated Successfully.',
//                             backgroundColor: AppColors.greenColor,
//                             textColor: AppColors.whiteColor,
//                           );
//                         })
//                         .catchError((error) {
//                           ToastUtils.showToastMessage(
//                             message: error.toString(),
//                             backgroundColor: AppColors.greenColor,
//                             textColor: AppColors.whiteColor,
//                           );
//                         });
//                   },
//                   icon: Icon(
//                     event.isFavourite
//                         ? Icons.favorite
//                         : Icons.favorite_border_outlined,
//                     color: Theme.of(context).cardColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///
///
// import 'package:evently_app_task/firebase_utils.dart';
// import 'package:evently_app_task/model/event.dart';
// import 'package:evently_app_task/providers/app_theme_provider.dart';
// import 'package:evently_app_task/utils/app_assets.dart';
// import 'package:evently_app_task/utils/app_colors.dart';
// import 'package:evently_app_task/utils/toast_utils.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../../../utils/size_utils.dart';
//
// class EventItemWidget extends StatelessWidget {
//   final Event event;
//
//   const EventItemWidget({super.key, required this.event});
//
//   String getEventImage(bool isDark) {
//     switch (event.eventCategoryIndex) {
//       case 1:
//         return isDark ? AppAssets.sportDark : AppAssets.sport;
//       case 2:
//         return isDark ? AppAssets.birthdayDark : AppAssets.birthday;
//       case 3:
//         return isDark ? AppAssets.meetingDark : AppAssets.meeting;
//       case 4:
//         return isDark ? AppAssets.bookClubDark : AppAssets.bookClub;
//       case 5:
//         return isDark ? AppAssets.exhibitionDark : AppAssets.exhibition;
//       default:
//         return isDark ? AppAssets.sportDark : AppAssets.sport;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var width = context.width;
//     var height = context.height;
//     var themeProvider = Provider.of<AppThemeProvider>(context);
//
//     return Container(
//       height: height * 0.23,
//       padding: EdgeInsets.symmetric(
//         vertical: height * 0.01,
//         horizontal: width * 0.02,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(width: 2, color: Theme.of(context).dividerColor),
//         image: DecorationImage(
//           fit: BoxFit.fill,
//           image: AssetImage(getEventImage(themeProvider.isDarkMode())),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: width * 0.02,
//               vertical: height * 0.01,
//             ),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Text(
//               DateFormat('dd MMM').format(event.eventDate),
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: width * 0.02),
//             decoration: BoxDecoration(
//               color: Theme.of(context).highlightColor,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 width: 2,
//                 color: Theme.of(context).dividerColor,
//               ),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     event.eventTitle,
//                     style: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     FirebaseUtils.updateIsFavourite(event)
//                         .then((value) {
//                           ToastUtils.showToastMessage(
//                             message: 'Event Updated Successfully.',
//                             backgroundColor: AppColors.greenColor,
//                             textColor: AppColors.whiteColor,
//                           );
//                         })
//                         .catchError((error) {
//                           ToastUtils.showToastMessage(
//                             message: error.toString(),
//                             backgroundColor: AppColors.greenColor,
//                             textColor: AppColors.whiteColor,
//                           );
//                         });
//                   },
//                   icon: Icon(
//                     event.isFavourite
//                         ? Icons.favorite
//                         : Icons.favorite_border_outlined,
//                     color: Theme.of(context).cardColor,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
///
import 'package:evently_app_task/firebase_utils.dart';
import 'package:evently_app_task/model/event.dart';
import 'package:evently_app_task/providers/app_theme_provider.dart';
import 'package:evently_app_task/utils/app_assets.dart';
import 'package:evently_app_task/utils/app_colors.dart';
import 'package:evently_app_task/utils/app_routes.dart';
import 'package:evently_app_task/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../utils/size_utils.dart';

class EventItemWidget extends StatelessWidget {
  final Event event;

  const EventItemWidget({super.key, required this.event});

  String getEventImage(bool isDark) {
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
    var width = context.width;
    var height = context.height;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.eventDetailsRouteName,
          arguments: event,
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: height * 0.23,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.01,
          horizontal: width * 0.02,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Theme.of(context).dividerColor,
          ),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              getEventImage(themeProvider.isDarkMode()),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
                vertical: height * 0.01,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: Text(
                DateFormat('dd MMM').format(event.eventDate),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.02,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      event.eventTitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseUtils.updateIsFavourite(event)
                          .then((value) {
                        ToastUtils.showToastMessage(
                          message: 'Event Updated Successfully.',
                          backgroundColor: AppColors.greenColor,
                          textColor: AppColors.whiteColor,
                        );
                      }).catchError((error) {
                        ToastUtils.showToastMessage(
                          message: error.toString(),
                          backgroundColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                        );
                      });
                    },
                    icon: Icon(
                      event.isFavourite
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
