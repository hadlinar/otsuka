import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {
  // static const String baseUrl = "http://10.0.2.2:3000/otsuka/ediscount";
  static const String baseUrl = "http://172.20.30.67:3000/otsuka/ediscount";

  static String ACCESS_TOKEN = "access_token";

  static int BLACK = 0xff000000;
  static int BLUE = 0xff77A2D2;
  static int WHITE = 0xffffffff;
  static int TOSCA = 0xff8CCED7;
  static int BACKGROUND = 0xffF5F5F5;
  static int RED = 0xffFF5F65;
  static int GREEN = 0xff36C238;
  static int GREY = 0xffD3DFEC;

  static const IC_WARNING = "assets/icons/ic_cancel.png";
  static const IC_CHECK = "assets/icons/ic_check.png";
  static const IC_CANCEL = "assets/icons/ic_cancel.png";

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
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Color(Global.RED), width: 3)
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
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Color(Global.TOSCA))
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(Global.TOSCA)),
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
}