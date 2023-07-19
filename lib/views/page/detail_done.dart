import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../bloc/pdk/pdk_bloc.dart';
import '../../models/pdk.dart';
import '../../models/user.dart';
import '../../utils/global.dart';

class DetailDonePDK extends StatefulWidget {
  PDK pdk;
  User user;

  DetailDonePDK(this.pdk, this.user);

  @override
  State<StatefulWidget> createState() {
    return _DetailDonePDKPage();
  }
}

class _DetailDonePDKPage extends State<DetailDonePDK> {
  late List<DetailPDK> detailPDK = [];
  late List<double> disc = [0];

  final currencyFormatter = NumberFormat('#,##0', 'ID');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PDKBloc>(context).add(GetDetailPDKEvent(widget.pdk.id.toString()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
            appBar:AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: SweepGradient(
                      colors: [Color(Global.TOSCA), Color(Global.BLUE)],
                      stops: [0, 1],
                      center: Alignment.bottomLeft,
                    )
                ),
              ),
              leading: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(Global.WHITE),
                  size: 25.0,
                ),
              ),
              title: Text(
                  "PDK Detail",
                  style: Global.getCustomFont(Global.WHITE, 15, 'medium')
              ),
              actions: [
                PopupMenuButton(
                    itemBuilder: (context){
                      return [
                        const PopupMenuItem<int>(
                          value: 0,
                          child: Text("PDK Info"),
                        ),
                      ];
                    },
                    onSelected:(value){
                      if(value == 0){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                content: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Table(
                                        columnWidths: const <int, TableColumnWidth> {
                                          0: FixedColumnWidth(90),
                                          2: FixedColumnWidth(124),
                                        },
                                        children: [
                                          TableRow(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Text(
                                                      "Draft No.",
                                                      style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Text(
                                                      widget.pdk.no_draft,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                )
                                              ]
                                          ),
                                          TableRow(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Text(
                                                      "PDK Maker",
                                                      style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.all(4),
                                                  child: Text(
                                                      widget.pdk.maker_name,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                )
                                              ]
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      }
                    }
                ),
              ],
            ),
            backgroundColor: Color(Global.BACKGROUND),
            body: BlocListener<PDKBloc, PDKBlocState>(
                listener: (context, state) {
                  print(state.toString());
                  if(state is LoadingPDKState) {
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: SpinKitDoubleBounce(
                          color: Color(Global.TOSCA),
                          size: 70,
                        ),
                      ),
                    );
                  }
                  if(state is GetDetailState) {
                    setState(() {
                      detailPDK = state.getPDKDetail;
                      for(int i = 0; i < detailPDK.length; i++) {
                        disc.add(detailPDK[i].total_disc);
                      }
                      disc.sort();
                    });
                    print(disc);
                    print(disc.length);
                    print(disc[disc.length-1]);
                  }
                  else {
                    Container();
                  }
                },
                child: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.only(top: 13, left: 19, right: 19, bottom: 13),
                      child: Column(
                        children: [
                          //status
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(7),
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(110),
                                              1: FixedColumnWidth(180),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Register No.",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.no_register ?? "-",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'bold')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.final_status != null ? (widget.pdk.final_status != false ? "Approved" : "Rejected") : "Processed",
                                                          style: TextStyle(
                                                            color: widget.pdk.final_status != null ? (widget.pdk.final_status != false ? const Color(0xff27A22B) : const Color(0xffF50206)) : const Color(0xffFFCC01),
                                                            fontSize: 13,
                                                            fontFamily: 'bold'
                                                          )
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              )
                          ),

                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                  color: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(7),
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(110),
                                              1: FixedColumnWidth(180),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Proposed by",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "CABANG ${widget.pdk.branch}",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Date created",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          DateFormat('d MMM yyyy').format(widget.pdk.date),
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Customer Code",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.kode_pelanggan,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Customer Name",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.cust,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Description",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.description!,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              )
                          ),

                          // approver 1
                          widget.pdk.user_approve_1 != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_2 != null ? "Approved" : (widget.pdk.final_status == false && widget.pdk.final_status != true ? "Rejected" : "Pending"),
                                                          style: TextStyle(
                                                            color: widget.pdk.user_approve_2 != null ? const Color(0xff27A22B) : (widget.pdk.final_status == false && widget.pdk.final_status != true ? const Color(0xffF50206) :const Color(0xffFFCC01)),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                          // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Branch Manager",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_1,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.all(7),
                                        padding: const EdgeInsets.all(7),
                                        width: MediaQuery.of(context).size.width / 1.1,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffE7ECF2),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  widget.pdk.user_desc_1!,
                                                  style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  DateFormat('d MMM yyyy').format(widget.pdk.date_approve_1!),
                                                  // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'book',
                                                  fontStyle: FontStyle.italic,
                                                  color: Color(0xff6E6E6E)
                                                )
                                              ),
                                            ),
                                          ]
                                        )
                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ) : Container(),

                          // approver 2
                          widget.pdk.user_approve_2 != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_3 != null ? "Approved" : (widget.pdk.final_status == false && widget.pdk.final_status != true ? "Rejected" : "Pending"),
                                                          style: TextStyle(
                                                            color: widget.pdk.user_approve_3 != null ? const Color(0xff27A22B) : (widget.pdk.final_status == false && widget.pdk.final_status != true ? const Color(0xffF50206) :const Color(0xffFFCC01)),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (Branch)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_2,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(7),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7ECF2),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      widget.pdk.user_desc_2!,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      DateFormat('d MMM yyyy').format(widget.pdk.date_approve_2!),
                                                      // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'book',
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xff6E6E6E)
                                                      )
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) : (widget.pdk.final_status != false ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Color(0xffFFCC01),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (Branch)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          " ",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) : Container()),

                          // approver 3
                          widget.pdk.user_approve_3 != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_4 != null ? "Approved" : (widget.pdk.final_status == false && widget.pdk.final_status != true ? "Rejected" : "Pending"),
                                                          style: TextStyle(
                                                            color: widget.pdk.user_approve_4 != null ? const Color(0xff27A22B) : (widget.pdk.final_status == false && widget.pdk.final_status != true ? const Color(0xffF50206) :const Color(0xffFFCC01)),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Rajawali Nusindo",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_3,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(7),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7ECF2),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      widget.pdk.user_desc_3!,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      DateFormat('d MMM yyyy').format(widget.pdk.date_approve_3!),
                                                      // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'book',
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xff6E6E6E)
                                                      )
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ) : (widget.pdk.final_status != false ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Color(0xffFFCC01),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Rajawali Nusindo",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          " ",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) : Container()),

                          // approver 4
                          widget.pdk.user_approve_4 != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_5 != null ? "Approved" : (widget.pdk.final_status == false && widget.pdk.final_status != true ? "Rejected" : "Pending"),
                                                          style: TextStyle(
                                                            color: widget.pdk.user_approve_5 != null ? const Color(0xff27A22B) : (widget.pdk.final_status == false && widget.pdk.final_status != true ? const Color(0xffF50206) :const Color(0xffFFCC01)),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_4,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(7),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7ECF2),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      widget.pdk.user_desc_4!,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      DateFormat('d MMM yyyy').format(widget.pdk.date_approve_4!),
                                                      // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'book',
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xff6E6E6E)
                                                      )
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) : (widget.pdk.final_status == false ? Container() : SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Color(0xffFFCC01),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          " ",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) ),

                          // approver 5
                          widget.pdk.user_approve_5 != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_6 != null && widget.pdk.final_status != true ? "Approved" : (widget.pdk.final_status == false && widget.pdk.final_status != true ? "Rejected" : "Pending"),
                                                          style: TextStyle(
                                                            color: widget.pdk.user_approve_6 != null ? const Color(0xff27A22B) : (widget.pdk.final_status == false && widget.pdk.final_status != true ? const Color(0xffF50206) :const Color(0xffFFCC01)),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_5,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(7),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7ECF2),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      widget.pdk.user_desc_5!,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      DateFormat('d MMM yyyy').format(widget.pdk.date_approve_5!),
                                                      // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'book',
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xff6E6E6E)
                                                      )
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ) : (widget.pdk.final_status != false ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Color(0xffFFCC01),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          " ",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ) : Container()),

                          // approver 6
                          disc[disc.length-1] >= 26.0 ? (widget.pdk.user_approve_6 != null && widget.pdk.final_status != null ? SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          widget.pdk.user_approve_6 != null && widget.pdk.final_status != false ? "Approved" : "Rejected",
                                                          style: TextStyle(
                                                            color: widget.pdk.final_status == false ? const Color(0xffF50206) : const Color(0xff27A22B),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                        // Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.approver_6,
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "Notes",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                                                      child: Text(
                                                          "",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.all(7),
                                          padding: const EdgeInsets.all(7),
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7ECF2),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Column(
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      widget.pdk.user_desc_6!,
                                                      style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Text(
                                                      DateFormat('d MMM yyyy').format(widget.pdk.date_approve_6!),
                                                      // style: Global.getCustomFont(Global.GREY, 13, 'book')
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: 'book',
                                                          fontStyle: FontStyle.italic,
                                                          color: Color(0xff6E6E6E)
                                                      )
                                                  ),
                                                ),
                                              ]
                                          )
                                      ),

                                    ],
                                  ),
                                ),
                              )
                          ) : SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Card(
                                color: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Table(
                                            columnWidths: const <int, TableColumnWidth> {
                                              0: FixedColumnWidth(120),
                                              1: FixedColumnWidth(178),
                                            },
                                            children: [
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: Text(
                                                          "Status",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                      child: const Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                            color: Color(0xffFFCC01),
                                                            fontFamily: 'book',
                                                            fontSize: 13,
                                                          )
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Otsuka Indonesia (HO)",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          " ",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          )) : Container(),

                          ListView.builder(
                              itemCount: detailPDK?.length,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return Card(
                                    elevation: 0,
                                    shadowColor: const Color(0xffBCBCBC),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 8),
                                        child: Column(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Table(
                                                  columnWidths: const <int, TableColumnWidth> {
                                                    0: FixedColumnWidth(140),
                                                    2: FixedColumnWidth(124),
                                                  },
                                                  children: [
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Item Product",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 8),
                                                            child: Text(
                                                                detailPDK[i].prod_name,
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 4, left: 4),
                                                            child: Text(
                                                                "Sales",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                  ],
                                                )
                                            ),
                                            const Divider(
                                              color: Color(0xff9A9B9F),
                                              thickness: 0.2,
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Table(
                                                  columnWidths: const <int, TableColumnWidth> {
                                                    0: FixedColumnWidth(140),
                                                    2: FixedColumnWidth(124),
                                                  },
                                                  children: [
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Qty",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                detailPDK[i].qty.toString(),
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "HNA",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                currencyFormatter.format(detailPDK[i].hna).toString(),
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Total Sales (Rp)",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                            child: Text(
                                                                currencyFormatter.format(detailPDK[i].total_sales).toString(),
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'bold')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 4, left: 4),
                                                            child: Text(
                                                                "Discount",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                  ],
                                                )
                                            ),
                                            const Divider(
                                              color: Color(0xff9A9B9F),
                                              thickness: 0.2,
                                            ),
                                            Container(
                                                padding: const EdgeInsets.only(top: 3),
                                                child: Table(
                                                  columnWidths: const <int, TableColumnWidth> {
                                                    0: FixedColumnWidth(140),
                                                    2: FixedColumnWidth(124),
                                                  },
                                                  children: [
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Rajawali Nusindo",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                              padding: const EdgeInsets.all(4),
                                                              child: Text(
                                                                  "${detailPDK[i].percent_disc_rn} %",
                                                                  style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                              ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Otsuka Indonesia",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 20),
                                                            child: Text(
                                                                "Outlet",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "${detailPDK[i].percent_disc_outlet} %",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 20),
                                                            child: Text(
                                                                "Goods Bonus Conversion",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "${detailPDK[i].percent_disc_konversi} %",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                    TableRow(
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "Total Discount",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                            child: Text(
                                                                "${detailPDK[i].percent_disc_rn + detailPDK[i].percent_disc_konversi + detailPDK[i].percent_disc_outlet} %",
                                                                style: Global.getCustomFont(Global.BLACK, 13, 'bold')
                                                            ),
                                                          )
                                                        ]
                                                    ),
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                    )
                                );
                              }
                          ),
                        ],
                      )
                  ),
                )
            )
        )
    );
  }

}