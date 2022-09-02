import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Muser/display_all_M_user.dart';
import 'package:login_admin/widget/widget_util.dart';

class AddMUser extends StatefulWidget {
  const AddMUser({Key? key}) : super(key: key);

  @override
  State<AddMUser> createState() => _AddMUserState();
}

class _AddMUserState extends State<AddMUser> {
  final _formKey = new GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_m_user');
  saveDataFb() async {
    _collectionRef.add({
      'password': passController.text,
      'username': userController.text,
    }).whenComplete(() {
      WidgetUtil().nextScreenRemoveUntil(
          context,
          DisplayMUser(
            muser: MUser(id: '', username: '', password: ''),
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
                    'Add M User',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                WidgetUtil().verspace(20),
                TextField(
                  controller: userController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "UserName",
                  ),
                ),
                WidgetUtil().verspace(10),
                TextField(
                  controller: passController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (userController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter UserName');
                      } else if (passController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Password');
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
