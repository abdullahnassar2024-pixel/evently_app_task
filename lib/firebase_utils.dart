import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app_task/model/event.dart';
import 'package:evently_app_task/model/my_user.dart';

class FirebaseUtils {
  static const String googleServerClientId =
      '860184557477-bshv3ku010kg4a42d9as24uhe665dbc1.apps.googleusercontent.com';

  static CollectionReference<MyUser> getUsersCollections() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static CollectionReference<Event> getEventsCollections() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static CollectionReference<Event> getEventsCollections1(String uId) {
    return getEventsCollections()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static Future<void> addUserInFirestore(MyUser myUser) {
    CollectionReference<MyUser> collectionRef = getUsersCollections();
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
    return docRef.set(myUser);
  }

  static Future<MyUser?> readUsersFromFirestore(String uId) async {
    DocumentSnapshot<MyUser> querySnapshot = await getUsersCollections()
        .doc(uId)
        .get();
    return querySnapshot.data();
  }

  static Future<void> addEventInFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventsCollections();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.eventId = docRef.id;
    return docRef.set(event);
  }

  static Stream<List<Event>> getAllEvents() {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventsCollections()
        .orderBy('event_date')
        .snapshots();

    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Stream<List<Event>> getFilterEvents({required int selectedIndex}) {
    Stream<QuerySnapshot<Event>> stream = FirebaseUtils.getEventsCollections()
        .where('event_category_index', isEqualTo: selectedIndex)
        .orderBy('event_date')
        .snapshots();

    return stream.map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> updateIsFavourite(Event event) async {
    await getEventsCollections().doc(event.eventId).update({
      'is_favourite': !event.isFavourite,
    });
  }

  static Stream<List<Event>> getAllFavouriteEvents() {
    return getEventsCollections()
        .where('is_favourite', isEqualTo: true)
        .orderBy('event_date')
        .snapshots()
        .map((querySnapshot) {
          return querySnapshot.docs.map((doc) {
            return doc.data();
          }).toList();
        });
  }
}
