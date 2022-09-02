import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/all_option_button.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/widget/widget_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = new GlobalKey<FormState>();
  final userController = TextEditingController();
  final passController = TextEditingController();
  List<Admin?> futureAlbum = [];
  CollectionReference _collectionRef1 =
      FirebaseFirestore.instance.collection('tbl_admin');
  Future<void> getDataAdmin() async {
    QuerySnapshot querySnapshot = await _collectionRef1.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('username'));
      futureAlbum.add(Admin(
        id: element.id,
        username: element.get('username'),
        password: element.get('password'),
      ));
    });
  }

  Future<void> saveData() async {
    futureAlbum.forEach((element) {
      if (userController.text == element!.username) {
        print("id :::::: " + element.username.toString());
      } else if (passController.text == element.password) {
        print("id :::::: " + element.password.toString());
      } else {
        Fluttertoast.showToast(msg: 'NOT FOUND USER');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataAdmin();
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
                    'Login User',
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
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                        saveData().whenComplete(() {
                          WidgetUtil()
                              .nextScreenRemoveUntil(context, OptionButton());
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
