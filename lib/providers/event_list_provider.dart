import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  int selectedIndex = 0;
  List<Event> eventList = [];
  List<Event> filterEventList = [];
  List<String> eventNameList = [];
  List<Event> favEventList = [];

  Future<void> getALLEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot = await FirebaseUtils.getEventCollection(
        uId).get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventList = eventList;
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  List<String> getEventNameList(BuildContext context) {
    return eventNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  Future<void> getFilterEventsFromFirestore(String uId) async {
    var querySnapshot = await FirebaseUtils.getEventCollection(uId)
        .orderBy('dateTime').where(
        'eventName', isEqualTo: eventNameList[selectedIndex]).get();
    filterEventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId).get();
    eventList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterEventList = eventList.where((event) {
      return event.eventName == eventNameList[selectedIndex];
    }
    ).toList();
    filterEventList.sort((event1, event2) {
      return event1.dateTime.compareTo(event2.dateTime);
    });
    notifyListeners();
  }

  Future<void> getAllFavEvents(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId).get();
    eventList = querySnapShot.docs.map((doc) {
      return doc.data();
    }).toList();
    favEventList = eventList.where((event) {
      return event.isFavorite == true;
    }
    ).toList();
    notifyListeners();
  }

  Future<void> getAllFavEventsFromFirebase(String uId) async {
    var querySnapShot = await FirebaseUtils.getEventCollection(uId).orderBy(
        'dateTime')
        .where('isFavorite', isEqualTo: true).get();
    favEventList = eventList.where((event) {
      return event.isFavorite == true;
    }
    ).toList();
    notifyListeners();
  }

  void updateIsfav(Event event, String uId) {
    FirebaseUtils.getEventCollection(uId).doc(event.id)
        .update({'isFavorite': event.isFavorite})
    //todo:online
        .then((value) {
      ToastUtils.toastMsg(msg: 'Event updated successfully',
          color: AppColors.primaryColor, textColor: AppColors.whiteColor);
      selectedIndex == 0 ? getALLEvents(uId) : getFilterEvents(uId);
      getAllFavEventsFromFirebase(uId);
    })
    //todo:offline
        .timeout(Duration(milliseconds: 500)
        , onTimeout: () {
          ToastUtils.toastMsg(msg: 'Event updated successfully',
              color: AppColors.primaryColor, textColor: AppColors.whiteColor);
          selectedIndex == 0 ? getALLEvents(uId) : getFilterEvents(uId);
          getAllFavEventsFromFirebase(uId);
        });

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) {
    selectedIndex = newSelectedIndex;
    selectedIndex == 0 ? getALLEvents(uId) : getFilterEventsFromFirestore(uId);
  }
  Future updateEvent(Event updatedEvent, String uId) async {
    try {
      final docRef = FirebaseUtils.getEventCollection(uId).doc(updatedEvent.id);
      await docRef.update(updatedEvent.toFireStore());
      await getALLEvents(uId);
      selectedIndex = 0;
      notifyListeners();
    } catch (e) {
      print("Error updating event: $e");
    }
  }

}






