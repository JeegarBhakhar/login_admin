import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/all_option_button.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Muser/add_m_user.dart';
import 'package:login_admin/screen/Muser/edit_m_user.dart';
import 'package:login_admin/widget/widget_util.dart';

class DisplayMUser extends StatefulWidget {
  final MUser muser;
  DisplayMUser({Key? key, required this.muser}) : super(key: key);

  @override
  State<DisplayMUser> createState() => _DisplayMUserState();
}

class _DisplayMUserState extends State<DisplayMUser> {
  List<MUser?> futureAlbum = [];

  int count = 0;
  final searchController = TextEditingController();
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_m_user');
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
                'Data Of M User',
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
                          "UserName : " + this.futureAlbum[position]!.username!,
                          style: titleStyle,
                        ),
                        subtitle: Text(
                          "Password : " + this.futureAlbum[position]!.password!,
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
          WidgetUtil().nextScreen(context, AddMUser());
        },
        tooltip: "Add More",
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _delete(BuildContext context, MUser muser) async {
    _collectionRef.doc(muser.id).delete().whenComplete(() {
      Fluttertoast.showToast(
        msg: "Delete User",
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
        futureAlbum.add(MUser(
          id: element.id,
          username: element.get('username'),
          password: element.get('password'),
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
      print('ELEMENT :::::: ' + element.get('wing'));
      futureAlbum.add(MUser(
        id: element.id,
        username: element.get('username'),
        password: element.get('password'),
      ));
    });
  }

  void navigateToDetail(MUser muser) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditMUser(
        muser: muser,
      );
    }));
  }
}
