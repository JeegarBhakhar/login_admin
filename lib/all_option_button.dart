import 'package:flutter/material.dart';
import 'package:login_admin/model/user_wingDisplay.dart';
import 'package:login_admin/screen/Event/dispaly_all_event.dart';
import 'package:login_admin/screen/Muser/display_all_M_user.dart';
import 'package:login_admin/screen/add_donate/diaplay_donate.dart';
import 'package:login_admin/screen/floor/display_all_floor_deatlis.dart';
import 'package:login_admin/screen/payer/display_all_payer.dart';
import 'package:login_admin/screen/wings/display_all_wing_deatails.dart';
import 'package:login_admin/widget/widget_util.dart';

class OptionButton extends StatefulWidget {
  const OptionButton({Key? key}) : super(key: key);

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      print('Wings');
                      WidgetUtil().nextScreen(
                          context,
                          WingsDisplay(
                            note: TblNote(id: '', wings: ''),
                          ));
                    },
                    child: WidgetUtil().button('Wings', 80, 180)),
                WidgetUtil().verspace(10),
                GestureDetector(
                    onTap: () {
                      print('Floor');
                      WidgetUtil().nextScreen(context,
                          FloorDisplay(floor: Floor(id: '', floor: '')));
                    },
                    child: WidgetUtil().button('Floor', 80, 180)),
                WidgetUtil().verspace(10),
                GestureDetector(
                    onTap: () {
                      print('Event');
                      WidgetUtil().nextScreen(context,
                          DisplayEvent(event: Event(id: '', event: '')));
                    },
                    child: WidgetUtil().button('Event', 80, 180)),
                WidgetUtil().verspace(10),
                GestureDetector(
                    onTap: () {
                      print('Payer');
                      WidgetUtil().nextScreen(
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
                    },
                    child: WidgetUtil().button('Payer', 80, 180)),
                WidgetUtil().verspace(10),
                GestureDetector(
                    onTap: () {
                      print('User');
                      WidgetUtil().nextScreen(
                          context,
                          DisplayMUser(
                              muser:
                                  MUser(id: '', username: '', password: '')));
                    },
                    child: WidgetUtil().button('User', 80, 180)),
                WidgetUtil().verspace(10),
                GestureDetector(
                    onTap: () {
                      print('Donet');
                      WidgetUtil().nextScreen(
                          context,
                          DispalyDonate(
                            event: Event(id: '', event: 'select Event name'),
                            payerTbl: PayerTbl(
                                id: '',
                                floorId: '',
                                floorName: '',
                                payerMobileNamber: '',
                                payerName: 'Select Payer Name',
                                wingId: '',
                                wingName: ''),
                          ));
                    },
                    child: WidgetUtil().button('Donet', 80, 180)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
