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
import '../../widget/custom_stepper.dart';

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
  late List<String> disc = [];

  static String convertToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: decimalDigit,
    );
    return currencyFormatter.format(number);
  }

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
                                                            color: widget.pdk.final_status != null ? (widget.pdk.final_status != false ? const Color(0xff27A22B) : const Color(0xffF50206)) : Color(Global.BLUE),
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
                                                          "Diajukan Oleh",
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
                                                          "Tanggal diajukan",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          DateFormat('HH:mm, d MMM yyyy').format(widget.pdk.date),
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
                                                          "Kode Pelanggan",
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
                                                          "Nama Pelanggan",
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
                                                          "Team Product Group",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.kategori_otsuka == "U" ? "Unite" : "Synergize",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              //segment
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "Produk Segment",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          widget.pdk.segmen == "Tender" ? "BPJS" : "Reguler",
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
                                                          "Deskripsi",
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

                          Card(
                            elevation: 0,
                            shadowColor: const Color(0xffBCBCBC),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(7),
                              child: ListView.builder(
                                itemCount: widget.pdk.level,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, i) {

                                  Map<int, String> approver = {
                                    0: widget.pdk.approver_1,
                                    1: widget.pdk.approver_1,
                                    2: widget.pdk.approver_2,
                                    3: widget.pdk.approver_3,
                                    4: widget.pdk.approver_4,
                                    5: widget.pdk.approver_5,
                                    6: widget.pdk.approver_6
                                  };

                                  Map<int, DateTime?> dateAppr = {
                                    0: widget.pdk.date_approve_1,
                                    1: widget.pdk.date_approve_1,
                                    2: widget.pdk.date_approve_2,
                                    3: widget.pdk.date_approve_3,
                                    4: widget.pdk.date_approve_4,
                                    5: widget.pdk.date_approve_5,
                                    6: widget.pdk.date_approve_6
                                  };

                                  Map<int, String?> userDesc = {
                                    0: widget.pdk.user_desc_1,
                                    1: widget.pdk.user_desc_1,
                                    2: widget.pdk.user_desc_2,
                                    3: widget.pdk.user_desc_3,
                                    4: widget.pdk.user_desc_4,
                                    5: widget.pdk.user_desc_5,
                                    6: widget.pdk.user_desc_6
                                  };

                                  if(i+1 == widget.user.role_id) {
                                    //APPROVED
                                    if(userDesc[i+1] == null ) {
                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: CustomStepper(status: "Approved", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level)
                                      );
                                    }

                                    //REJECT
                                    else if (userDesc[i+1] != null) {
                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: CustomStepper(status: "Rejected", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level, desc: userDesc[i+1]!)

                                      );
                                    }
                                  }
                                  else if (i+1 > widget.user.role_id) {
                                    if(i+1 <= widget.pdk.level) {
                                      if(userDesc[i+1] == null && dateAppr[i+1] != null) {
                                        //approved
                                        return SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: CustomStepper(status: "Approved", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level)
                                        );
                                      }
                                      else if(userDesc[i+1] != null) {
                                        // reject
                                        return SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.1,
                                            child: CustomStepper(status: "Rejected", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level, desc: userDesc[i+1]!)

                                        );
                                      }
                                      else if(widget.pdk.final_status != null && dateAppr[i+1] == null) {
                                        return Container();
                                      } else {
                                        return SizedBox(
                                            width: MediaQuery.of(context).size.width / 1.1,
                                            child: CustomStepper(status: "Waiting", index: i, level: widget.pdk.level)
                                        );
                                      }
                                    }
                                    else if (userDesc[i+1] != null) {
                                      // rejected
                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: CustomStepper(status: "Rejected", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level, desc: userDesc[i+1]!)
                                      );
                                    }
                                    else {
                                      return SizedBox(
                                          width: MediaQuery.of(context).size.width / 1.1,
                                          child: CustomStepper(status: "Approved", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level)

                                      );
                                    }
                                  }
                                  else if (i+1 < widget.user.role_id) {
                                    return SizedBox(
                                        width: MediaQuery.of(context).size.width / 1.1,
                                        child: CustomStepper(status: "Approved", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level)
                                    );
                                  }
                                },
                              ),
                            ),
                          ),

                          ListView.builder(
                              itemCount: detailPDK.length,
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
                                                                "Kode Produk",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(left: 4, top: 4, right: 4, bottom: 8),
                                                            child: Text(
                                                                detailPDK[i].kode_barang,
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
                                                                "Item Produk",
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
                                                                "QTY",
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
                                                                "HNA (Rp)",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                convertToIdr(double.parse(detailPDK[i].hna).ceil(), 0),
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
                                                                convertToIdr(double.parse(detailPDK[i].total_sales).ceil(), 0),
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
                                                                "Diskon",
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
                                                                "Diskon Outlet",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "${detailPDK[i].percent_disc_outlet}%",
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
                                                                "Diskon Bonus",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.all(4),
                                                            child: Text(
                                                                "${detailPDK[i].percent_disc_konversi}%",
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
                                                                "Diskon Total",
                                                                style: Global.getCustomFont(Global.DARK_GREY, 13, 'bold')
                                                            ),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 8),
                                                            child: Text(
                                                                "${detailPDK[i].total_disc}%",
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