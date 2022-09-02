import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Event/dispaly_all_event.dart';
import 'package:login_admin/widget/widget_util.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final _formKey = new GlobalKey<FormState>();
  final eventController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');
  saveDataFb() async {
    _collectionRef.add({
      'event_name': eventController.text,
    }).whenComplete(() {
      WidgetUtil().nextScreenRemoveUntil(
          context, DisplayEvent(event: Event(id: '', event: '')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Add Event',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                WidgetUtil().verspace(20),
                TextField(
                  controller: eventController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Event",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (eventController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Event');
                      } else {
                        saveDataFb();
                      }
                    },
                    child: WidgetUtil().button('Saved', 60, 200)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
