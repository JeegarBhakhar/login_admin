import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/floor/add_floor.dart';
import 'package:login_admin/screen/floor/edit_floor.dart';

import '../../all_option_button.dart';
import '../../widget/widget_util.dart';

class FloorDisplay extends StatefulWidget {
  final Floor floor;
  FloorDisplay({Key? key, required this.floor}) : super(key: key);

  @override
  State<FloorDisplay> createState() => _FloorDisplayState();
}

class _FloorDisplayState extends State<FloorDisplay> {
  List<Floor?> futureAlbum = [];

  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_floors');
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
                'Data Of Floor',
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
                          "Floor name",
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          this.futureAlbum[position]!.floor!,
                          style: titleStyle,
                        ),
                        trailing: GestureDetector(
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
                                        _delete(context, futureAlbum[position]!)
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
          WidgetUtil().nextScreen(context, AddFloor());
        },
        tooltip: "Add More",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _delete(BuildContext context, Floor floor) async {
    _collectionRef.doc(floor.id).delete().whenComplete(() {
      Fluttertoast.showToast(
        msg: "Delete Floor",
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
        futureAlbum.add(Floor(
          id: element.id,
          floor: element.get('floor'),
        ));
      });
    });
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
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

  void navigateToDetail(Floor floor) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditFloor(
        floor: floor,
      );
    }));
  }
}
