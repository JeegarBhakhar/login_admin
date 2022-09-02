import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/add_donate/diaplay_donate.dart';
import 'package:login_admin/widget/widget_util.dart';

class SelectEvent extends StatefulWidget {
  const SelectEvent({Key? key}) : super(key: key);

  @override
  State<SelectEvent> createState() => _SelectEventState();
}

class _SelectEventState extends State<SelectEvent> {
  List<Event?> futureAlbum = [];
  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_event');
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("data :::::::::::::::::::::::: ");
    print(allData);
    querySnapshot.docs.forEach((element) {
      print('ELEMENT :::::: ' + element.get('event_name'));
      setState(() {
        futureAlbum.add(Event(
          id: element.id,
          event: element.get('event_name'),
        ));
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
                  event: Event(id: '', event: '')));
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Data Of Event',
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
                        title: Text(
                          "Event name",
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          this.futureAlbum[position]!.event!,
                          style: titleStyle,
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

  void navigateToDetail(Event event) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DispalyDonate(
        event: event,
        payerTbl: PayerTbl(
            id: '',
            floorId: '',
            floorName: '',
            payerMobileNamber: '',
            payerName: '',
            wingId: '',
            wingName: ''),
      );
    }));
  }
}
