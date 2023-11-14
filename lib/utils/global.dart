import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Global {
  // static const String baseUrl = "http://10.0.2.2:3000/otsuka/ediscount";
  // static const String baseUrl = "http://103.140.207.25:3000/otsuka/ediscount";
  static const String baseUrl = "http://172.20.60.14:3000/otsuka/ediscount";

  static String ACCESS_TOKEN = "access_token";

  static int BLACK = 0xff000000;
  static int BLUE = 0xff77A2D2;
  static int WHITE = 0xffffffff;
  static int TOSCA = 0xff8CCED7;
  static int BACKGROUND = 0xffF5F5F5;
  static int RED = 0xffFF5F65;
  static int GREEN = 0xff36C238;
  static int GREY = 0xffD3DFEC;
  static int DARK_GREY = 0xff7E7E7E;
  static int YELLOW = 0xffFFCC01;

  static const IC_WARNING = "assets/icons/ic_warning.png";
  static const IC_CHECK = "assets/icons/ic_check.png";
  static const IC_CANCEL = "assets/icons/ic_cancel.png";
  static const IC_EMPTY = "assets/icons/ic_empty.png";

  static TextStyle? getCustomFont(int color, double fontSize, String fontName) {
    return TextStyle(
      color: Color(color),
      fontFamily: fontName,
      fontSize: fontSize
    );
  }

  static AlertDialog defaultModal(
      VoidCallback action,
      BuildContext context,
      String iconPath,
      String titleModal,
      String positiveBtnText,
      bool isShowingNegativeButton) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Image.asset(
        iconPath,
        height: 50,
        width: 50,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                titleModal,
                style: getCustomFont(BLACK, 16, 'bold'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              isShowingNegativeButton
                  ? Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                  color: Color(Global.RED),
                                  width: 3
                              )
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(Global.WHITE)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Color(RED),
                            fontFamily: 'bold',
                            fontSize: 14
                        ),
                      )))
                  : Container(),
              isShowingNegativeButton
                  ? Container(
                width: 20,
              )
                  : Container(),
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(Global.BLUE))
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(Global.BLUE)),
                      ),
                      onPressed: action,
                      child: Text(
                        positiveBtnText,
                        style: getCustomFont(WHITE, 14, 'bold'),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  static Card getCardList(String draft, String cabang, String cust, DateTime date) {
    return Card(
        elevation: 0,
        shadowColor: const Color(0xffBCBCBC),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
            padding: const EdgeInsets.only(left: 12, top: 7),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(cust, style: Global.getCustomFont(BLACK, 14, 'medium')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(draft, style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("CABANG ${cabang}", style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, right: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(DateFormat('d MMM yyyy').format(date), style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),
              ],
            )
        )
    );
  }


  static Card getDoneCardList(String kodPel, String cabang, String cust, DateTime date, bool? status) {
    return Card(
        elevation: 0,
        shadowColor: const Color(0xffBCBCBC),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
            padding: const EdgeInsets.only(left: 12, top: 7),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 3),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(cust, style: Global.getCustomFont(BLACK, 14, 'medium')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(kodPel, style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text("CABANG ${cabang}", style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(right: 7),
                    padding: const EdgeInsets.all(5),
                    // width: status == null ? 82 : (status ? 78 : 71),
                    decoration: BoxDecoration(
                      color: status == null ? Color(BLUE) : (status ? const Color(0xff27A22B) : const Color(0xffF50206)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(status == null ? "Processed" : (status ? "Approved" : "Rejected"), style: Global.getCustomFont(WHITE, 13, 'book')),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 8, right: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(DateFormat('d MMM yyyy').format(date), style: Global.getCustomFont(DARK_GREY, 14, 'book')),
                  ),
                ),
              ],
            )
        )
    );
  }
}