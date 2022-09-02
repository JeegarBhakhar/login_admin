import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Event/dispaly_all_event.dart';
import 'package:login_admin/widget/widget_util.dart';

class EditEvent extends StatefulWidget {
  final Event event;
  EditEvent({Key? key, required this.event}) : super(key: key);

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = new GlobalKey<FormState>();
  final eventController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');
  Future<void> saveData() async {
    final form = _formKey.currentState;
    String ec = eventController.text;
    await _collectionRef.doc(widget.event.id).update({
      'event_name': ec,
    });
    if (!form!.validate()) {
    } else {
      form.save();
      print('floor : $ec');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      eventController.text = widget.event.event!;
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
                    'Edit Event',
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
                    labelText: "Floor",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (eventController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Event');
                      } else {
                        saveData().whenComplete(() {
                          WidgetUtil().nextScreenRemoveUntil(
                              context,
                              DisplayEvent(
                                event: Event(
                                    id: widget.event.id,
                                    event: eventController.text),
                              ));
                        });
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
