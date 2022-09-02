import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Event/dispaly_all_event.dart';
import 'package:login_admin/widget/widget_util.dart';

class SelectEventDonte extends StatefulWidget {
  final Event event;
  final AddDonte addDonte;
  const SelectEventDonte(
      {Key? key, required this.event, required this.addDonte})
      : super(key: key);

  @override
  State<SelectEventDonte> createState() => _SelectEventDonteState();
}

class _SelectEventDonteState extends State<SelectEventDonte> {
  List<AddDonte?> futureAlbum = [];
  List<AddDonte?> eventeAlbum = [];
  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_donet');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getDataDonet();
  }

  Future<void> getDataDonet() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      if (element.get('event_id') == widget.event.id) {
        print("....................... = " + element.toString());
        setState(() {
          eventeAlbum.add(AddDonte(
            id: element.id,
            eventId: element.get('event_id'),
            eventName: element.get('event_name'),
            floorId: element.get('floor_id'),
            floorName: element.get('floor_name'),
            payerMobileNamber: element.get('payer_mobile_number'),
            payerName: element.get('payer_name'),
            wingId: element.get('wing_id'),
            wingName: element.get('wing_name'),
            amount: element.get('amount'),
            comment: element.get('comment'),
          ));
        });
      }
      print('ELEMENT :::::: ' + eventeAlbum.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? titleStyle = Theme.of(context).textTheme.subtitle1;
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          WidgetUtil().nextScreen(
              context, DisplayEvent(event: Event(id: '', event: '')));
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Donet Of Payer',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              WidgetUtil().verspace(10),
              Expanded(
                child: ListView.builder(
                    itemCount: eventeAlbum.length,
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
                                "Event id : " +
                                    this.eventeAlbum[position]!.eventId!,
                                style: titleStyle,
                              ),
                              Text(
                                "Event Name : " +
                                    this.eventeAlbum[position]!.eventName!,
                                style: titleStyle,
                              ),
                              Text(
                                "Floor Id : " +
                                    this.eventeAlbum[position]!.floorId!,
                                style: titleStyle,
                              ),
                              Text(
                                "Floor Name : " +
                                    this.eventeAlbum[position]!.floorName!,
                                style: titleStyle,
                              ),
                              Text(
                                "Payer Name : " +
                                    this.eventeAlbum[position]!.payerName!,
                                style: titleStyle,
                              ),
                              Text(
                                "Payer Mobile Number : " +
                                    this
                                        .eventeAlbum[position]!
                                        .payerMobileNamber!,
                                style: titleStyle,
                              ),
                              Text(
                                "wing id : " +
                                    this.eventeAlbum[position]!.wingId!,
                                style: titleStyle,
                              ),
                              Text(
                                "wing Name : " +
                                    this.eventeAlbum[position]!.wingName!,
                                style: titleStyle,
                              ),
                              Text(
                                "Amount : " +
                                    this.eventeAlbum[position]!.amount!,
                                style: titleStyle,
                              ),
                              Text(
                                "Comment : " +
                                    this.eventeAlbum[position]!.comment!,
                                style: titleStyle,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
