import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/all_option_button.dart';
import 'package:login_admin/screen/Event/add_event.dart';
import 'package:login_admin/screen/Event/edit_event.dart';
import 'package:login_admin/screen/Event/select_event_donte.dart';
import 'package:login_admin/widget/widget_util.dart';

import '../../model/user_wingDisplay.dart';

class DisplayEvent extends StatefulWidget {
  final Event event;
  DisplayEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<DisplayEvent> createState() => _DisplayEventState();
}

class _DisplayEventState extends State<DisplayEvent> {
  List<Event?> futureAlbum = [];

  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getData();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            WidgetUtil().nextScreenRemoveUntil(context, OptionButton());
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          WidgetUtil().nextScreen(context, OptionButton());
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Data Of Event',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            WidgetUtil().verspace(20),
            Expanded(
              child: ListView.builder(
                  itemCount: futureAlbum.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child: ListTile(
                        title: Text(
                          "Event name",
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          this.futureAlbum[position]!.event!,
                          style: titleStyle,
                        ),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            print("Edit");
                            navigateToDetail(this.futureAlbum[position]!);
                          },
                        ),
                        onTap: () {
                          navigateToDonteDetail(this.futureAlbum[position]!);
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WidgetUtil().nextScreen(context, AddEvent());
        },
        tooltip: "Add More",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _delete(BuildContext context, Event event) async {
    _collectionRef.doc(event.id).delete().whenComplete(() {
      Fluttertoast.showToast(
        msg: "Delete Event",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      updateListView();
    });
  }

  Future<void> updateListView() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    futureAlbum.clear();
    querySnapshot.docs.forEach((element) {
      setState(() {
        futureAlbum.add(Event(
          id: element.id,
          event: element.get('event_name'),
        ));
      });
    });
  }

  Future<void> getData() async {
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

  void navigateToDetail(Event event) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditEvent(
        event: event,
      );
    }));
  }

  void navigateToDonteDetail(Event event) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SelectEventDonte(
        event: event,
        addDonte: AddDonte(
            id: '',
            eventId: '',
            eventName: '',
            floorId: '',
            floorName: '',
            payerMobileNamber: '',
            payerName: '',
            wingId: '',
            wingName: '',
            amount: '',
            comment: ''),
      );
    }));
  }
}
