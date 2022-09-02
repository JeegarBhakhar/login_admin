import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/payer/display_all_payer.dart';
import 'package:login_admin/widget/widget_util.dart';

class AddPayer extends StatefulWidget {
  const AddPayer({Key? key}) : super(key: key);

  @override
  State<AddPayer> createState() => _AddPayerState();
}

class _AddPayerState extends State<AddPayer> {
  final _formKey = new GlobalKey<FormState>();
  List<Floor?> futureAlbum = [];
  List<TblNote?> futureAlbum1 = [];
  String? Floor_ids;
  String? Wing_ids;
  CollectionReference _collectionRef1 =
      FirebaseFirestore.instance.collection('tbl_floors');
  CollectionReference _collectionRef2 =
      FirebaseFirestore.instance.collection('tbl_wings');
  Future<void> getDataFloor() async {
    QuerySnapshot querySnapshot = await _collectionRef1.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('floor'));
      futureAlbum.add(Floor(
        id: element.id,
        floor: element.get('floor'),
      ));
    });
  }

  Future<void> getDataWing() async {
    QuerySnapshot querySnapshot = await _collectionRef2.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('wing'));
      futureAlbum1.add(TblNote(
        id: element.id,
        wings: element.get('wing'),
      ));
    });
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_payer');
  final floorNameController = TextEditingController();
  final payerMobileController = TextEditingController();
  final payerNameController = TextEditingController();
  final wingNameController = TextEditingController();
  saveDataFb() async {
    futureAlbum.forEach((element) {
      if (floorNameController.text == element!.floor) {
        Floor_ids = element.id;
      }
    });
    futureAlbum1.forEach((element) {
      if (wingNameController.text == element!.wings) {
        Wing_ids = element.id;
      }
    });
    _collectionRef.add({
      'floor_id': '$Floor_ids',
      'floor_name': floorNameController.text,
      'payer_mobile_number': payerMobileController.text,
      'payer_name': payerNameController.text,
      'wing_id': '$Wing_ids',
      'wing_name': wingNameController.text,
    }).whenComplete(() {
      WidgetUtil().nextScreenRemoveUntil(
          context,
          DisplayAllPayer(
              payerTbl: PayerTbl(
                  id: '',
                  floorId: '',
                  floorName: '',
                  payerMobileNamber: '',
                  payerName: '',
                  wingId: '',
                  wingName: '')));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFloor();
    getDataWing();
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
                    'Add Payer',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                WidgetUtil().verspace(20),
                TextField(
                  controller: floorNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Floor Name",
                  ),
                ),
                WidgetUtil().verspace(10),
                TextField(
                  controller: payerNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Payer Name",
                  ),
                ),
                WidgetUtil().verspace(10),
                TextField(
                  controller: payerMobileController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Payer Mobile Number",
                  ),
                ),
                WidgetUtil().verspace(10),
                TextField(
                  controller: wingNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Wing Name",
                  ),
                ),
                WidgetUtil().verspace(20),
                GestureDetector(
                    onTap: () {
                      if (floorNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Floor Name');
                      } else if (payerMobileController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: 'Please enter Payer Mobile Number');
                      } else if (payerNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Payer Name');
                      } else if (wingNameController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please enter Wing Name');
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
