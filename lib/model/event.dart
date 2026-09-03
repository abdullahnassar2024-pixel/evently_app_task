import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  //todo: collectionName
  static const String collectionName = 'Events';
  //todo: Attributes
  String eventId;
  String eventImage;
  String eventName;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavourite;
  int eventCategoryIndex;

  //todo : Constructor
  Event({
    this.eventId = '',
    required this.eventImage,
    required this.eventName,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    required this.eventCategoryIndex,
    this.isFavourite = false,
  });

  //todo: json => object
  Event.fromFireStore(Map<String, dynamic> data)
    : this(
        eventId: data['event_id'],
        eventImage: data['event_image'],
        eventName: data['event_name'],
        eventTitle: data['event_title'],
        eventDescription: data['event_description'],
        eventCategoryIndex: data['event_category_index'],
        eventDate: (data['event_date'] as Timestamp).toDate(),
        isFavourite: data['is_favourite'],
      );
  //todo: object => json
  Map<String, dynamic> toFirestore() {
    return {
      'event_id': eventId,
      'event_image': eventImage,
      'event_name': eventName,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'event_category_index': eventCategoryIndex,
      'event_date': eventDate, //Timestamp
      'is_favourite': isFavourite,
    };
  }
}
