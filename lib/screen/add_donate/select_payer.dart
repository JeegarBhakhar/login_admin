import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/add_donate/diaplay_donate.dart';
import 'package:login_admin/widget/widget_util.dart';

class SelectPayer extends StatefulWidget {
  Event? event;
  SelectPayer(this.event);

  @override
  State<SelectPayer> createState() => _SelectPayerState();
}

class _SelectPayerState extends State<SelectPayer> {
  List<PayerTbl?> futureAlbum = [];
  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_payer');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('payer_name'));
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          WidgetUtil().nextScreen(
              context,
              DispalyDonate(
                  payerTbl: PayerTbl(
                      id: '',
                      floorId: '',
                      floorName: '',
                      payerMobileNamber: '',
                      payerName: '',
                      wingId: '',
                      wingName: ' '),
                  event: widget.event!));
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
    );
  }

  void navigateToDetail(PayerTbl payer_tbl) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DispalyDonate(
        event: widget.event!,
        payerTbl: payer_tbl,
      );
    }));
  }
}
