import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';

class EventViewModel extends ChangeNotifier {
  List<Event?> futureAlbum = [];
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');
  Future<void> getDataEvent() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('event_name'));
      futureAlbum.add(Event(
        id: element.id,
        event: element.get('event_name'),
      ));
    });
  }
}
