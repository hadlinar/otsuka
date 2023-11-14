import 'package:ediscount/views/page/login.dart';
import 'package:ediscount/widget/custom_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

import '../../bloc/pdk/pdk_bloc.dart';
import '../../models/pdk.dart';
import '../../models/user.dart';
import '../../utils/global.dart';
import '../../widget/customer_text_field.dart';

class DetailPendingPDK extends StatefulWidget {
  PDK pdk;
  User? user;
  SuccessPostPDK? successPostPDK;

  DetailPendingPDK(this.pdk, this.user, {this.successPostPDK});

  @override
  State<StatefulWidget> createState() {
    return _DetailPendingPDKPage();
  }
}

typedef SuccessPostPDK = void Function(int resultMessage, BuildContext context);

class _DetailPendingPDKPage extends State<DetailPendingPDK> {
  late List<DetailPDK> detailPDK = [];
  late TextEditingController notesController;
  late List<TextEditingController> listDiscController = [];
  late List<String> disc = [];
  late List<String> totalDisc = [];
  GlobalKey<FormState> _formKey = GlobalKey();
  String notes = '';
  bool _val = false;
  bool _discChanged = false;

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
    notesController = TextEditingController();
    notesController.addListener(() {
      final _val = notesController.text.isNotEmpty;

      setState(() {
        this._val = _val;
      });
    });
  }

  @override
  void dispose() {
    notesController.dispose();
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
              "Detail PDK",
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
            if(state is SuccessPostApproveState) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Global.defaultModal(() {
                      Navigator.of(context).pop();
                      widget.successPostPDK!(200, context);
                    }, context, Global.IC_CHECK, "Approved", "Ok", false);
                  }
              );
            }
            if(state is SuccessPostRejectState) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Global.defaultModal(() {
                      notes = '';
                      notesController.text = "";
                      _val = false;
                      widget.successPostPDK!(200, context);
                    }, context, Global.IC_CHECK, "Rejected", "Ok", false);
                  }
              );
            }
            if(state is GetDetailState) {
              setState(() {
                detailPDK = state.getPDKDetail;
                disc = [];
                listDiscController = [
                  for (int i = 0; i < detailPDK.length; i++)
                    TextEditingController()
                ];

                for(int i = 0; i < detailPDK.length; i++) {
                  listDiscController[i].text = detailPDK[i].percent_disc_rn.toString();
                  disc.add(detailPDK[i].percent_disc_rn);
                  totalDisc.add(detailPDK[i].total_disc);
                }
                totalDisc.sort();
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
                                        0: FixedColumnWidth(120),
                                        1: FixedColumnWidth(178),
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
                                        //category
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
                                1: widget.pdk.approver_1,
                                2: widget.pdk.approver_2,
                                3: widget.pdk.approver_3,
                                4: widget.pdk.approver_4,
                                5: widget.pdk.approver_5,
                                6: widget.pdk.approver_6
                              };

                              Map<int, DateTime?> dateAppr = {
                                1: widget.pdk.date_approve_1,
                                2: widget.pdk.date_approve_2,
                                3: widget.pdk.date_approve_3,
                                4: widget.pdk.date_approve_4,
                                5: widget.pdk.date_approve_5,
                                6: widget.pdk.date_approve_6
                              };

                              if(i+1 == widget.user?.role_id || i+1 == 0) {
                                return Container();
                              }else if(i+1 < widget.user!.role_id) {
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.1,
                                    child: CustomStepper(status: "Approved", index: i, approver: approver[i+1].toString(), date: DateFormat('HH:mm, d MMM yyyy').format(dateAppr[i+1]!).toString(), level: widget.pdk.level)
                                );
                              }
                              else if(i+1 > widget.user!.role_id && i+1 <= widget.pdk.level) {
                                return SizedBox(
                                    width: MediaQuery.of(context).size.width / 1.1,
                                    child: CustomStepper(status: "Waiting", index: i, level: widget.pdk.level)
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
                                                          "Produk Item",
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
                                                      padding: const EdgeInsets.only(top: 20, left: 4),
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
                                                        // double.parse(detailPDK[i].total_sales).ceil().toString(),
                                                          "${double.parse(listDiscController[i].text)}%",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),

                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      // padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 20),
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
                                                      padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 30),
                                                      child: Text(
                                                          "Diskon Outlet",
                                                          style: Global.getCustomFont(Global.DARK_GREY, 13, 'book')
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(4),
                                                      child: Text(
                                                          "${(double.parse(detailPDK[i].total_disc) - double.parse(listDiscController[i].text) - double.parse(detailPDK[i].percent_disc_konversi))}%",
                                                          style: Global.getCustomFont(Global.BLACK, 13, 'book')
                                                      ),
                                                    )
                                                  ]
                                              ),
                                              TableRow(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.only(top:4, right: 4, bottom: 4, left: 30),
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

                    widget.user?.role_id == 2 && widget.user?.flg_am == null ? SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          elevation: 0,
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            child: TextFormField(
                              style: Global.getCustomFont(Global.BLACK, 13, 'medium'),
                              maxLines: 5,
                              maxLength: 200,
                              controller: notesController,
                              onChanged: (text) {
                                notes = text;
                              },
                              decoration: InputDecoration(
                                labelText: "Notes",
                                alignLabelWithHint: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius .circular(10),
                                    borderSide: BorderSide()),
                              ),
                            ),
                          ),
                        )
                    ) : Container(),
                    widget.user?.flg_am == null ? SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 0,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                    margin: const EdgeInsets.only(bottom: 5),
                                    color: Colors.white,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 93,
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

                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {

                                                      return AlertDialog(
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10)
                                                            )
                                                        ),
                                                        content: StatefulBuilder(
                                                          builder: (BuildContext context, StateSetter setState) {
                                                            return SizedBox(
                                                                width: 322,
                                                                child: Column(
                                                                    mainAxisSize: MainAxisSize.min,
                                                                    children: [
                                                                      TextFormField(
                                                                        key: _formKey,
                                                                        style: Global.getCustomFont(Global.BLACK, 13, 'medium'),
                                                                        maxLines: 5,
                                                                        maxLength: 200,
                                                                        controller: notesController,
                                                                        onChanged: (text) {
                                                                          notes = text;
                                                                          setState(() {
                                                                            _val = notesController.text == "" ? false : true;
                                                                          });
                                                                        },
                                                                        decoration: InputDecoration(
                                                                          labelText: "Notes",
                                                                          errorText: !_val ? 'Notes can\'t be empty' : null,
                                                                          alignLabelWithHint: true,
                                                                          border: OutlineInputBorder(
                                                                              borderRadius: BorderRadius .circular(10),
                                                                              borderSide: BorderSide()),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: const EdgeInsets.only(top: 10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            ElevatedButton(
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
                                                                                onPressed: (){
                                                                                  notes = '';
                                                                                  notesController.text = "";
                                                                                  _val = false;
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text(
                                                                                  "Cancel",
                                                                                  style: TextStyle(
                                                                                      color: Color(Global.RED),
                                                                                      fontFamily: 'bold',
                                                                                      fontSize: 13
                                                                                  ),
                                                                                )
                                                                            ),
                                                                            Container(
                                                                              width: 14,
                                                                            ),
                                                                            ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  disabledForegroundColor: Color(Global.BLUE).withOpacity(0.38),
                                                                                  disabledBackgroundColor: Color(Global.BLUE).withOpacity(0.12),
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(18.0),
                                                                                    // side: BorderSide(color: notesController.text.isEmpty ? Color(Global.BLUE).withOpacity(0.12) : Color(Global.BLUE))
                                                                                  ),
                                                                                ),
                                                                                onPressed: _val ? (){
                                                                                  Navigator.pop(context);
                                                                                  BlocProvider.of<PDKBloc>(context).add(
                                                                                      PostRejectPDKEvent(
                                                                                          notesController.text,
                                                                                          DateTime.now().toString(),
                                                                                          widget.pdk.id,
                                                                                          widget.pdk.kategori_otsuka!,
                                                                                          widget.pdk.branch_id
                                                                                      )
                                                                                  );
                                                                                } : null,
                                                                                child: const Text(
                                                                                  "Submit",
                                                                                  style: TextStyle(
                                                                                      color: Colors.white,
                                                                                      fontFamily: 'bold',
                                                                                      fontSize: 13
                                                                                  ),
                                                                                )
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )

                                                                    ]
                                                                )
                                                            );
                                                          }
                                                        )
                                                      );
                                                    }
                                                  );
                                                },
                                                child: Text(
                                                  "Reject",
                                                  style: TextStyle(
                                                      color: Color(Global.RED),
                                                      fontFamily: 'bold',
                                                      fontSize: 13
                                                  ),
                                                )
                                            ),
                                          ),

                                          Container(
                                            width: 14,
                                          ),
                                          SizedBox(
                                            width: 93,
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
                                                onPressed: () {
                                                  BlocProvider.of<PDKBloc>(context).add(
                                                      PostApprovePDKEvent(
                                                          notes == "" ? null : notes,
                                                          DateTime.now().toString(),
                                                          widget.pdk.id,
                                                          widget.pdk.kategori_otsuka!,
                                                          widget.pdk.branch_id,
                                                          '0.0',
                                                          0
                                                      )
                                                  );
                                                },
                                                child: const Text(
                                                  "Approve",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'bold',
                                                      fontSize: 13
                                                  ),
                                                )
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                )
                              ],
                            )
                        )
                    ) : Container(),
                  ],
                )
            ),
          )
        )
      )
    );
  }

}