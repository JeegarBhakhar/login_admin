import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/wings/display_all_wing_deatails.dart';
import 'package:login_admin/widget/widget_util.dart';

class AddWings extends StatefulWidget {
  const AddWings({Key? key}) : super(key: key);

  @override
  State<AddWings> createState() => _AddWingsState();
}

class _AddWingsState extends State<AddWings> {
  final _formKey = new GlobalKey<FormState>();
  final wingController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_wings');
  saveDataFb() async {
    _collectionRef.add({
      'wing': wingController.text,
    }).whenComplete(() {
      WidgetUtil().nextScreenRemoveUntil(
          context,
          WingsDisplay(
            note: TblNote(id: '', wings: ''),
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
                    'Add Wing',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                WidgetUtil().verspace(20),
                TextField(
                  controller: wingController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Wing",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (wingController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Wing');
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
