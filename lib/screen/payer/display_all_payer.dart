import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/all_option_button.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/payer/add_payer.dart';
import 'package:login_admin/screen/payer/edit_payer.dart';

import '../../widget/widget_util.dart';

class DisplayAllPayer extends StatefulWidget {
  final PayerTbl payerTbl;
  DisplayAllPayer({Key? key, required this.payerTbl}) : super(key: key);

  @override
  State<DisplayAllPayer> createState() => _DisplayAllPayerState();
}

class _DisplayAllPayerState extends State<DisplayAllPayer> {
  List<PayerTbl?> futureAlbum = [];

  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_payer');
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
                'Data Of Payer',
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
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Floor id : " +
                                  this.futureAlbum[position]!.floorId!,
                              style: titleStyle,
                            ),
                            Text(
                              "Floor Name : " +
                                  this.futureAlbum[position]!.floorName!,
                              style: titleStyle,
                            ),
                            Text(
                              "Payer Mobile Number : " +
                                  this
                                      .futureAlbum[position]!
                                      .payerMobileNamber!,
                              style: titleStyle,
                            ),
                            Text(
                              "Payer Name : " +
                                  this.futureAlbum[position]!.payerName!,
                              style: titleStyle,
                            ),
                            Text(
                              "wing id : " +
                                  this.futureAlbum[position]!.wingId!,
                              style: titleStyle,
                            ),
                            Text(
                              "wing Name : " +
                                  this.futureAlbum[position]!.wingName!,
                              style: titleStyle,
                            ),
                          ],
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                              onTap: () {
                                print("delete");
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Are You Sure?'),
                                      content: Text('Delete the Contect'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            _delete(context,
                                                    futureAlbum[position]!)
                                                .whenComplete(() {
                                              Navigator.pop(context, 'OK');
                                            });
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          navigateToDetail(this.futureAlbum[position]!);
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
          WidgetUtil().nextScreen(context, AddPayer());
        },
        tooltip: "Add More",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _delete(BuildContext context, PayerTbl payerTbl) async {
    _collectionRef.doc(payerTbl.id).delete().whenComplete(() {
      Fluttertoast.showToast(
        msg: "Delete payer",
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
        futureAlbum.add(PayerTbl(
            id: element.id,
            floorId: element.get('floor_id'),
            floorName: element.get('floor_name'),
            payerMobileNamber: element.get('payer_mobile_number'),
            payerName: element.get('payer_name'),
            wingId: element.get('wing_id'),
            wingName: element.get('wing_name')));
      });
    });
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('payer_mobile_number'));
      futureAlbum.add(PayerTbl(
          id: element.id,
          floorId: element.get('floor_id'),
          floorName: element.get('floor_name'),
          payerMobileNamber: element.get('payer_mobile_number'),
          payerName: element.get('payer_name'),
          wingId: element.get('wing_id'),
          wingName: element.get('wing_name')));
    });
  }

  void navigateToDetail(PayerTbl payerTbl) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditPayer(payerTbl: payerTbl);
    }));
  }
}
