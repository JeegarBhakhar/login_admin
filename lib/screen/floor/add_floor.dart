import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/floor/display_all_floor_deatlis.dart';
import 'package:login_admin/widget/widget_util.dart';

class AddFloor extends StatefulWidget {
  const AddFloor({Key? key}) : super(key: key);

  @override
  State<AddFloor> createState() => _AddFloorState();
}

class _AddFloorState extends State<AddFloor> {
  final _formKey = new GlobalKey<FormState>();
  final floorController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_floors');
  saveDataFb() async {
    _collectionRef.add({
      'floor': floorController.text,
    }).whenComplete(() {
      WidgetUtil().nextScreenRemoveUntil(
          context,
          FloorDisplay(
            floor: Floor(id: '', floor: ''),
          ));
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
                    'Add Floor',
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
                        Fluttertoast.showToast(msg: 'Please enter Floor');
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
