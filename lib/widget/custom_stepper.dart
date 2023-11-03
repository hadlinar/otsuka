import 'package:flutter/material.dart';

import '../utils/global.dart';

class CustomStepper extends StatefulWidget {
  final String? approver;
  final String? date;
  final String status;
  final int index;
  final int? level;
  final String? desc;

  const CustomStepper({Key? key,
    this.approver,
    this.date,
    required this.status,
    required this.index,
    this.level,
    this.desc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomStepper();
  }
}

class _CustomStepper extends State<CustomStepper> {

  Map<int, String> jobLevel = {
    1: "Branch Manager",
    2: "RM",
    3: "Rajawali Nusindo",
    4: "NSM",
    5: "Asst. Dir",
    6: "BUD"
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 5),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                  color: widget.status == "Approved" ? Color(Global.GREEN) : (widget.status == "Rejected" ? Color(Global.RED) : Color(Global.YELLOW)),
                  shape: BoxShape.circle,
                  border: Border.all(color: widget.status == "Approved" ? Color(Global.GREEN) : widget.status == "Rejected" ? Color(Global.RED) : Color(Global.YELLOW))),
            ),
            Text(
              widget.status,
              style: TextStyle(
                color: widget.status == "Approved" ? Color(Global.GREEN) : (widget.status == "Rejected" ? Color(Global.RED) : Color(Global.YELLOW)),
                fontFamily: 'book',
                fontSize: 13
              ),
            ),
          ],
        ),
        widget.status == "Approved" ? Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration:  BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 2,
                    color: (widget.level!-1) == widget.index ? Color(Global.WHITE) : Color(Global.GREEN),
                  )
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                      jobLevel[widget.index+1].toString(),
                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                  )
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                    widget.approver!,
                    style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                )
              )
            ],
          ),
        ) : ( widget.status == "Rejected" ? Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration:  BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 2,
                    color: (widget.level!-1) == widget.index ? Color(Global.WHITE) : Color(Global.RED),
                  )
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                      jobLevel[widget.index+1].toString(),
                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                      widget.approver!,
                      style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                  )
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                      widget.desc!,
                      style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                  )
              )
            ],
          ),
        ) : Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration:  BoxDecoration(
              border: Border(
                  left: BorderSide(
                    width: 2,
                    color: (widget.level!-1) == widget.index ? Color(Global.WHITE) : Color(Global.YELLOW),
                  )
              )
          ),
          child: Text(
              jobLevel[widget.index+1].toString(),
              style: Global.getCustomFont(Global.BLACK, 13, 'book')
          ),
        )),
      ],
    );
  }
}