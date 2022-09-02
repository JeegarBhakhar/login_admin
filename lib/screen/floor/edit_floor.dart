import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/floor/display_all_floor_deatlis.dart';
import 'package:login_admin/widget/widget_util.dart';

class EditFloor extends StatefulWidget {
  final Floor floor;
  EditFloor({Key? key, required this.floor}) : super(key: key);

  @override
  State<EditFloor> createState() => _EditFloorState();
}

class _EditFloorState extends State<EditFloor> {
  final _formKey = new GlobalKey<FormState>();
  final floorController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_floors');
  Future<void> saveData() async {
    final form = _formKey.currentState;
    String fc = floorController.text;
    await _collectionRef.doc(widget.floor.id).update({
      'floor': fc,
    });
    if (!form!.validate()) {
    } else {
      form.save();
      print('floor : $fc');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      floorController.text = widget.floor.floor!;
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
                    'Edit Wing',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                WidgetUtil().verspace(20),
                TextField(
                  controller: floorController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Floor",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (floorController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Wing');
                      } else {
                        saveData().whenComplete(() {
                          WidgetUtil().nextScreenRemoveUntil(
                              context,
                              FloorDisplay(
                                  floor: Floor(
                                      id: widget.floor.id,
                                      floor: floorController.text)));
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
