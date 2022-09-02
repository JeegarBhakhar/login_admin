import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/widget/common_util.dart';

import 'enum.dart';

class EventViewModel extends ChangeNotifier {
  Status get status => _status;
  Status _status = Status.none;
  late Event _event;
  Event get event => _event;
  List<Event?> futureAlbum = [];
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');

  Future<void> getSearchList() async {
    CommonUtil().checkInternetConnection().then((value) {
      if (value) {
        _status = Status.loading;
        notifyListeners();
        _collectionRef.get().then((response) {
          if (response.statusCode == 200) {
            _event = Event.fromJson(json.decode(response.body));
            _status = Status.success;
            notifyListeners();
          } else {
            _status = Status.failed;
            notifyListeners();
          }
        });
      } else {
        _status = Status.noInternet;
        notifyListeners();
      }
    });
  }

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
