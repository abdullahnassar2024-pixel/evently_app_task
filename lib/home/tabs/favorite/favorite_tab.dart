
import 'package:evently_app_task/firebase_utils.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../model/event.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/custom_text_field.dart';
import '../home/event_item_widget.dart';

class FavoriteTab extends StatefulWidget {
  const FavoriteTab({super.key});

  @override
  State<FavoriteTab> createState() => _FavoriteTabState();
}

class _FavoriteTabState extends State<FavoriteTab> {
  Stream<List<Event>>? favouriteStream;
  List<Event> favouriteList = [];
  List<Event> filteredFavouriteList = [];

  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    favouriteStream = FirebaseUtils.getAllFavouriteEvents();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void searchEvent(String searchText) {
    setState(() {
      filteredFavouriteList = favouriteList.where((event) {
        return event.eventName.toLowerCase().contains(searchText.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = context.width;
    var height = context.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: SafeArea(
        child: Column(
          spacing: height * 0.02,
          children: [
            CustomTextField(
              filled: true,
              fillColor: Theme.of(context).highlightColor,
              borderColor: Theme.of(context).dividerColor,
              controller: searchController,
              onChanged: searchEvent,
              hintText: AppLocalizations.of(context)!.search_event,
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              suffixIcon: Icon(
                Icons.search,
                color: Theme.of(context).cardColor,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<Event>>(
                stream: favouriteStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainLightColor,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_favorite_event_found,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    );
                  }

                  favouriteList = snapshot.data!;

                  if (searchController.text.isEmpty) {
                    filteredFavouriteList = favouriteList;
                  }

                  if (filteredFavouriteList.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.no_favorite_event_found,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    );
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      return EventItemWidget(
                        event: filteredFavouriteList[index],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * 0.02);
                    },
                    itemCount: filteredFavouriteList.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
