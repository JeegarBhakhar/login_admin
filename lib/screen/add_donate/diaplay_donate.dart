import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_admin/all_option_button.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/add_donate/select_event.dart';
import 'package:login_admin/screen/add_donate/select_payer.dart';
import 'package:login_admin/widget/widget_util.dart';

class DispalyDonate extends StatefulWidget {
  final Event event;
  final PayerTbl payerTbl;
  const DispalyDonate({Key? key, required this.payerTbl, required this.event})
      : super(key: key);

  @override
  State<DispalyDonate> createState() => _DispalyDonateState();
}

class _DispalyDonateState extends State<DispalyDonate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('tbl_donet');
  saveDataFb() async {
    _collectionRef.add({
      'event_id': widget.event.id,
      'event_name': widget.event.event,
      'floor_id': widget.payerTbl.floorId,
      'floor_name': widget.payerTbl.floorName,
      'payer_mobile_number': widget.payerTbl.payerMobileNamber,
      'payer_name': widget.payerTbl.payerName,
      'wing_id': widget.payerTbl.wingId,
      'wing_name': widget.payerTbl.wingName,
      'amount': amountController.text,
      'comment': commentController.text,
    }).whenComplete(() => {
          WidgetUtil().nextScreenRemoveUntil(context, OptionButton()),
        });
  }

  final amountController = TextEditingController();
  final commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            child: WillPopScope(
              onWillPop: () async {
                WidgetUtil().nextScreen(context, OptionButton());
                return false;
              },
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Donate Form',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    ),
                  ),
                  WidgetUtil().verspace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Event',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  WidgetUtil().verspace(8),
                  GestureDetector(
                    onTap: () {
                      WidgetUtil().nextScreenReplace(context, SelectEvent());
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(22)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.event.event!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 23),
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  WidgetUtil().verspace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Payer Name',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  WidgetUtil().verspace(8),
                  GestureDetector(
                    onTap: () {
                      WidgetUtil().nextScreenReplace(
                          context, SelectPayer(widget.event));
                    },
                    child: Container(
                      height: 60,
                      width: 180,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(22)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.payerTbl.payerName!,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 23),
                          ),
                          Icon(
                            Icons.navigate_next_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  WidgetUtil().verspace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Floor Name : ${widget.payerTbl.floorName}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  WidgetUtil().verspace(10),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Wing Name : ${widget.payerTbl.wingName}',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ),
                  WidgetUtil().verspace(10),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Amount",
                    ),
                  ),
                  WidgetUtil().verspace(8),
                  TextField(
                    controller: commentController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Comment",
                    ),
                  ),
                  WidgetUtil().verspace(15),
                  GestureDetector(
                      onTap: () {
                        if (amountController.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Please enter amount');
                        } else {
                          saveDataFb();
                        }
                      },
                      child: WidgetUtil().button('save', 50, 200)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
