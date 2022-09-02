import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/wings/display_all_wing_deatails.dart';
import 'package:login_admin/widget/widget_util.dart';

class EditWings extends StatefulWidget {
  final TblNote note;
  EditWings({Key? key, required this.note}) : super(key: key);

  @override
  State<EditWings> createState() => _EditWingsState();
}

class _EditWingsState extends State<EditWings> {
  final _formKey = new GlobalKey<FormState>();
  final wingController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_wings');
  Future<void> saveData() async {
    final form = _formKey.currentState;
    String wg = wingController.text;
    await _collectionRef.doc(widget.note.id).update({
      'wing': wg,
    });
    if (!form!.validate()) {
    } else {
      form.save();
      print('wing : $wg');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      wingController.text = widget.note.wings!;
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
                        saveData().whenComplete(() {
                          WidgetUtil().nextScreenRemoveUntil(
                              context,
                              WingsDisplay(
                                  note: TblNote(
                                      id: widget.note.id,
                                      wings: wingController.text)));
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
